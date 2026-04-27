import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:uuid/uuid.dart';

/// Reserved tag context for the "口味偏好" basic-info chip.
const _tasteContext = 'taste';

class PersonDetailSheet extends ConsumerStatefulWidget {
  final String personId;

  const PersonDetailSheet({super.key, required this.personId});

  @override
  ConsumerState<PersonDetailSheet> createState() => _PersonDetailSheetState();
}

class _PersonDetailSheetState extends ConsumerState<PersonDetailSheet> {
  final _tagController = TextEditingController();
  TagSentiment _sentiment = TagSentiment.neutral;

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final person = ref.watch(personByIdProvider(widget.personId));
    final tagsAsync = ref.watch(personTagsProvider(widget.personId));

    if (person == null) return const SizedBox.shrink();

    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          _Handle(),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 48),
              children: [
                _PersonHeader(person: person),
                const SizedBox(height: 28),
                _BasicInfoSection(person: person),
                const Divider(height: 36),
                _TagsSection(personId: widget.personId, tagsAsync: tagsAsync),
                const Divider(height: 36),
                _AddTagSection(
                  controller: _tagController,
                  sentiment: _sentiment,
                  onSentimentChanged: (s) => setState(() => _sentiment = s),
                  onSubmit: _submitTag,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitTag() {
    final label = _tagController.text.trim();
    if (label.isEmpty) return;
    final now = DateTime.now();
    ref.read(personTagsProvider(widget.personId).notifier).addTag(
          PreferenceTag(
            id: const Uuid().v4(),
            personNodeId: widget.personId,
            label: label,
            sentiment: _sentiment,
            createdAt: now,
            updatedAt: now,
          ),
        );
    _tagController.clear();
    setState(() => _sentiment = TagSentiment.neutral);
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _PersonHeader extends StatelessWidget {
  final PersonNode person;
  const _PersonHeader({required this.person});

  @override
  Widget build(BuildContext context) {
    final color = avatarColor(person.name);
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Text(
            person.name.isNotEmpty ? person.name[0] : '?',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          person.name,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _BasicInfoSection extends ConsumerWidget {
  final PersonNode person;
  const _BasicInfoSection({required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(personTagsProvider(person.id));
    final tags = tagsAsync.valueOrNull ?? [];
    final tasteTag = tags.firstWhereOrNull((t) => t.context == _tasteContext);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '基本信息'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // 性别
            _InfoChip(
              icon: Icons.person_outline,
              label: person.gender?.isNotEmpty == true
                  ? '性别：${person.gender}'
                  : '性别未填',
              onTap: () => _editTextField(
                context,
                title: '性别',
                hint: '例：男 / 女 / 其他',
                current: person.gender,
                onSave: (v) => ref.read(personsProvider.notifier).upsert(
                      person.copyWith(
                          gender: v.isEmpty ? null : v,
                          updatedAt: DateTime.now()),
                    ),
              ),
            ),
            // 口味偏好
            _InfoChip(
              icon: Icons.restaurant_outlined,
              label: tasteTag != null ? '口味：${tasteTag.label}' : '口味未填',
              onTap: () => _editTaste(context, ref, tasteTag),
            ),
            // MBTI
            _InfoChip(
              icon: Icons.psychology_outlined,
              label: person.mbti?.isNotEmpty == true
                  ? 'MBTI：${person.mbti}'
                  : 'MBTI未填',
              onTap: () => _editTextField(
                context,
                title: 'MBTI',
                hint: '例：INFP',
                current: person.mbti,
                onSave: (v) => ref.read(personsProvider.notifier).upsert(
                      person.copyWith(
                          mbti: v.isEmpty ? null : v,
                          updatedAt: DateTime.now()),
                    ),
              ),
            ),
            // 有车
            _InfoChip(
              icon: Icons.directions_car_outlined,
              label: person.hasVehicle
                  ? '有车（${person.vehicleSeats ?? '?'}座）'
                  : '无车',
              onTap: () => _editVehicle(context, ref, person),
            ),
          ],
        ),
      ],
    );
  }

  void _editTaste(
    BuildContext context,
    WidgetRef ref,
    PreferenceTag? existing,
  ) {
    final controller =
        TextEditingController(text: existing?.label ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('口味偏好'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hint: Text('例：不吃辣，喜欢清淡')),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              Navigator.pop(ctx);
              if (value.isEmpty) return;
              final now = DateTime.now();
              if (existing != null) {
                ref.read(personTagsProvider(person.id).notifier).addTag(
                      existing.copyWith(label: value, updatedAt: now),
                    );
              } else {
                ref.read(personTagsProvider(person.id).notifier).addTag(
                      PreferenceTag(
                        id: const Uuid().v4(),
                        personNodeId: person.id,
                        label: value,
                        sentiment: TagSentiment.neutral,
                        context: _tasteContext,
                        source: 'basic_info',
                        createdAt: now,
                        updatedAt: now,
                      ),
                    );
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _editVehicle(BuildContext context, WidgetRef ref, PersonNode person) {
    final seatsController =
        TextEditingController(text: person.vehicleSeats?.toString() ?? '');
    bool hasVehicle = person.hasVehicle;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('交通工具'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('有车'),
                value: hasVehicle,
                onChanged: (v) => setState(() => hasVehicle = v),
              ),
              if (hasVehicle)
                TextField(
                  controller: seatsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '座位数'),
                ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ref.read(personsProvider.notifier).upsert(
                      person.copyWith(
                        hasVehicle: hasVehicle,
                        vehicleSeats: hasVehicle
                            ? int.tryParse(seatsController.text)
                            : null,
                        updatedAt: DateTime.now(),
                      ),
                    );
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  void _editTextField(
    BuildContext context, {
    required String title,
    required String hint,
    required String? current,
    required void Function(String) onSave,
  }) {
    final controller = TextEditingController(text: current ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: hint),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onSave(controller.text.trim());
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _TagsSection extends ConsumerWidget {
  final String personId;
  final AsyncValue<List<PreferenceTag>> tagsAsync;

  const _TagsSection({required this.personId, required this.tagsAsync});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '偏好标签'),
        const SizedBox(height: 12),
        tagsAsync.when(
          loading: () => const SizedBox(
              height: 32,
              child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2))),
          error: (e, _) => Text('$e',
              style: const TextStyle(color: Colors.red)),
          data: (tags) {
            // Exclude the taste tag — it lives in basic info
            final prefTags =
                tags.where((t) => t.context != _tasteContext).toList();
            if (prefTags.isEmpty) {
              return Text(
                '还没有偏好标签',
                style: TextStyle(color: Colors.grey.shade400),
              );
            }
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: prefTags
                  .map((tag) => _TagChip(
                        tag: tag,
                        onDelete: () => ref
                            .read(personTagsProvider(personId).notifier)
                            .removeTag(tag.id),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _AddTagSection extends StatelessWidget {
  final TextEditingController controller;
  final TagSentiment sentiment;
  final ValueChanged<TagSentiment> onSentimentChanged;
  final VoidCallback onSubmit;

  const _AddTagSection({
    required this.controller,
    required this.sentiment,
    required this.onSentimentChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, '添加标签'),
        const SizedBox(height: 12),
        // Sentiment selector
        Row(
          children: TagSentiment.values.map((s) {
            final selected = sentiment == s;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(_sentimentLabel(s)),
                selected: selected,
                selectedColor: _sentimentColor(s).withOpacity(0.25),
                labelStyle: TextStyle(
                  color: selected ? _sentimentColor(s) : null,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.normal,
                ),
                onSelected: (_) => onSentimentChanged(s),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onSubmit(),
                decoration: InputDecoration(
                  hintText: '例：不喜欢嘈杂的地方、爱吃日料',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: onSubmit,
              style: FilledButton.styleFrom(
                  minimumSize: const Size(56, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14))),
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _InfoChip(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

class _TagChip extends StatelessWidget {
  final PreferenceTag tag;
  final VoidCallback onDelete;

  const _TagChip({required this.tag, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final color = _sentimentColor(tag.sentiment);
    return Chip(
      label: Text(tag.label),
      backgroundColor: color.withOpacity(0.12),
      side: BorderSide(color: color.withOpacity(0.35)),
      deleteIcon: Icon(Icons.close, size: 15, color: color),
      onDeleted: onDelete,
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

Widget _sectionLabel(BuildContext context, String text) => Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
    );

String _sentimentLabel(TagSentiment s) => switch (s) {
      TagSentiment.positive => '喜好 ✓',
      TagSentiment.negative => '厌恶 ✗',
      TagSentiment.neutral => '中性',
    };

Color _sentimentColor(TagSentiment s) => switch (s) {
      TagSentiment.positive => const Color(0xFF2E7D32),
      TagSentiment.negative => const Color(0xFFC62828),
      TagSentiment.neutral => const Color(0xFF546E7A),
    };

extension _ListExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
