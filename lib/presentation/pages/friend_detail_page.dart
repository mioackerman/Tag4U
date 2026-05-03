import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:uuid/uuid.dart';

class FriendDetailPage extends ConsumerStatefulWidget {
  final String personId;
  const FriendDetailPage({super.key, required this.personId});

  @override
  ConsumerState<FriendDetailPage> createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends ConsumerState<FriendDetailPage> {
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personByIdProvider(widget.personId));
    final tagsAsync = ref.watch(personTagsProvider(widget.personId));

    if (person == null) {
      return const Scaffold(body: Center(child: Text('找不到该好友')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red.shade400,
            tooltip: '删除好友',
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: tagsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (allTags) {
          final prefTags = allTags
              .where((t) => t.context == null || t.context != 'taste')
              .toList();
          // Tags from their shared card (imported).
          final sharedTags =
              prefTags.where((t) => t.source == 'imported').toList();
          // Tags the local user added about this friend.
          final myTags =
              prefTags.where((t) => t.source != 'imported').toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Avatar ────────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: avatarColor(person.name),
                      child: Text(
                        person.name.isNotEmpty ? person.name[0] : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(person.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    if (person.mbti != null) ...[
                      const SizedBox(height: 4),
                      Text(person.mbti!,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 13)),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Friend's own public tags (from card) ──────────────────
              _TagSection(
                title: 'TA 的公开标签',
                icon: Icons.person_outline,
                color: Colors.teal.shade600,
                tags: sharedTags,
                emptyHint: '暂无（可通过名片导入）',
                onDelete: null,
              ),
              const SizedBox(height: 12),

              // ── My custom tags about this friend ──────────────────────
              _TagSection(
                title: '我的标注',
                icon: Icons.label_outline,
                color: Colors.blue.shade600,
                tags: myTags,
                emptyHint: '还没有添加标注',
                onDelete: (tag) => ref
                    .read(personTagsProvider(widget.personId).notifier)
                    .removeTag(tag.id),
              ),
              const SizedBox(height: 12),

              // ── Add tag input ─────────────────────────────────────────
              _AddTagInput(
                controller: _tagController,
                onSubmit: () => _submitTag(person),
              ),
            ],
          );
        },
      ),
    );
  }

  void _submitTag(PersonNode person) {
    final label = _tagController.text.trim();
    if (label.isEmpty) return;
    final now = DateTime.now();
    ref.read(personTagsProvider(widget.personId).notifier).addTag(
          PreferenceTag(
            id: const Uuid().v4(),
            personNodeId: person.id,
            label: label,
            source: 'user_explicit',
            createdAt: now,
            updatedAt: now,
          ),
        );
    _tagController.clear();
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final person = ref.read(personByIdProvider(widget.personId));
    if (person == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除 ${person.name}？'),
        content: const Text('此操作不可撤销，包括所有标注数据。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                FilledButton.styleFrom(backgroundColor: Colors.red.shade400),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await ref.read(personsProvider.notifier).delete(widget.personId);
      if (mounted) Navigator.pop(context);
    }
  }
}

// ── Tag section ───────────────────────────────────────────────────────────────

class _TagSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<PreferenceTag> tags;
  final String emptyHint;
  final void Function(PreferenceTag)? onDelete;

  const _TagSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.tags,
    required this.emptyHint,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (tags.isEmpty)
            Text(emptyHint,
                style: TextStyle(
                    fontSize: 12, color: Colors.grey.shade400))
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags
                  .map((tag) => _FriendTagChip(
                        tag: tag,
                        color: color,
                        onDelete:
                            onDelete != null ? () => onDelete!(tag) : null,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _FriendTagChip extends StatelessWidget {
  final PreferenceTag tag;
  final Color color;
  final VoidCallback? onDelete;

  const _FriendTagChip({
    required this.tag,
    required this.color,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
      deleteIcon: onDelete != null
          ? Icon(Icons.close, size: 14, color: color)
          : null,
      onDeleted: onDelete,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

// ── Add tag input ─────────────────────────────────────────────────────────────

class _AddTagInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const _AddTagInput({required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '添加我的标注',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: '例：不喜欢嘈杂的地方',
                    hintStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    isDense: true,
                  ),
                  onSubmitted: (_) => onSubmit(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: onSubmit,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  minimumSize: const Size(40, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
