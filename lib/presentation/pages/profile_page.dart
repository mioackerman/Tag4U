import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:uuid/uuid.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _tagController = TextEditingController();
  bool _tagIsPublic = true;

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selfAsync = ref.watch(selfPersonProvider);
    // Always watch using the fixed constant ID so the watcher count is stable.
    final tagsAsync = ref.watch(personTagsProvider(selfPersonId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的名片'),
        centerTitle: false,
      ),
      body: selfAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('错误：$e')),
        data: (self) {
          final tagsData = tagsAsync.valueOrNull ?? [];
          final prefTags =
              tagsData.where((t) => t.context == null || t.context != 'taste').toList();
          final publicTags = prefTags.where((t) => t.isPublic).toList();
          final privateTags = prefTags.where((t) => !t.isPublic).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Avatar + name ───────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: avatarColor(self.name),
                      child: Text(
                        self.name.isNotEmpty ? self.name[0] : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => _editName(context, self.name),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            self.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 6),
                          Icon(Icons.edit_outlined,
                              size: 16, color: Colors.grey.shade500),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '点击名字修改',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Public + Private tags side by side ──────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _TagColumn(
                      title: '公开标签',
                      icon: Icons.public_outlined,
                      color: Colors.blue.shade600,
                      tags: publicTags,
                      onDelete: (tag) => _removeTag(tag.id),
                      onToggle: (tag) => _togglePublic(tag),
                      toggleTooltip: '设为私密',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TagColumn(
                      title: '私密标签',
                      icon: Icons.lock_outline,
                      color: Colors.orange.shade700,
                      tags: privateTags,
                      onDelete: (tag) => _removeTag(tag.id),
                      onToggle: (tag) => _togglePublic(tag),
                      toggleTooltip: '设为公开',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Add tag input ───────────────────────────────────────────
              _AddTagSection(
                controller: _tagController,
                isPublic: _tagIsPublic,
                onPublicChanged: (v) => setState(() => _tagIsPublic = v),
                onSubmit: () => _submitTag(self.id),
              ),
            ],
          );
        },
      ),
    );
  }

  void _editName(BuildContext context, String current) {
    final ctrl = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('修改名字'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: '你的名字'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              final name = ctrl.text.trim();
              Navigator.pop(ctx);
              if (name.isNotEmpty) {
                ref.read(selfPersonProvider.notifier).updateName(name);
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _submitTag(String personId) {
    final label = _tagController.text.trim();
    if (label.isEmpty) return;
    final now = DateTime.now();
    ref.read(personTagsProvider(personId).notifier).addTag(
          PreferenceTag(
            id: const Uuid().v4(),
            personNodeId: personId,
            label: label,
            isPublic: _tagIsPublic,
            createdAt: now,
            updatedAt: now,
          ),
        );
    _tagController.clear();
  }

  void _removeTag(String tagId) {
    final selfId = ref.read(selfPersonProvider).valueOrNull?.id;
    if (selfId == null) return;
    ref.read(personTagsProvider(selfId).notifier).removeTag(tagId);
  }

  void _togglePublic(PreferenceTag tag) {
    final selfId = ref.read(selfPersonProvider).valueOrNull?.id;
    if (selfId == null) return;
    ref.read(personTagsProvider(selfId).notifier).addTag(
          tag.copyWith(isPublic: !tag.isPublic, updatedAt: DateTime.now()),
        );
  }
}

// ── Tag column (public or private) ───────────────────────────────────────────

class _TagColumn extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<PreferenceTag> tags;
  final void Function(PreferenceTag) onDelete;
  final void Function(PreferenceTag) onToggle;
  final String toggleTooltip;

  const _TagColumn({
    required this.title,
    required this.icon,
    required this.color,
    required this.tags,
    required this.onDelete,
    required this.onToggle,
    required this.toggleTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            Text(
              '暂无',
              style: TextStyle(
                  fontSize: 12, color: Colors.grey.shade400),
            )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags
                  .map((tag) => _ProfileTagChip(
                        tag: tag,
                        color: color,
                        onDelete: () => onDelete(tag),
                        onToggle: () => onToggle(tag),
                        toggleTooltip: toggleTooltip,
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _ProfileTagChip extends StatelessWidget {
  final PreferenceTag tag;
  final Color color;
  final VoidCallback onDelete;
  final VoidCallback onToggle;
  final String toggleTooltip;

  const _ProfileTagChip({
    required this.tag,
    required this.color,
    required this.onDelete,
    required this.onToggle,
    required this.toggleTooltip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onToggle,
      child: Tooltip(
        message: toggleTooltip,
        child: Chip(
          label: Text(tag.label, style: const TextStyle(fontSize: 12)),
          backgroundColor: color.withValues(alpha: 0.1),
          side: BorderSide(color: color.withValues(alpha: 0.3)),
          deleteIcon: Icon(Icons.close, size: 14, color: color),
          onDeleted: onDelete,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}

// ── Add tag section ───────────────────────────────────────────────────────────

class _AddTagSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isPublic;
  final ValueChanged<bool> onPublicChanged;
  final VoidCallback onSubmit;

  const _AddTagSection({
    required this.controller,
    required this.isPublic,
    required this.onPublicChanged,
    required this.onSubmit,
  });

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
            '添加标签',
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
                    hintText: '例：喜欢安静的地方',
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
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('可见性：', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              ChoiceChip(
                label: const Text('公开', style: TextStyle(fontSize: 12)),
                selected: isPublic,
                selectedColor: Colors.blue.shade100,
                onSelected: (_) => onPublicChanged(true),
              ),
              const SizedBox(width: 6),
              ChoiceChip(
                label: const Text('私密', style: TextStyle(fontSize: 12)),
                selected: !isPublic,
                selectedColor: Colors.orange.shade100,
                onSelected: (_) => onPublicChanged(false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
