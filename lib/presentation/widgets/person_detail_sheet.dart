import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/entity_detail_sheet.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:uuid/uuid.dart';

const _tasteContext = 'taste';

/// Detail bottom sheet for a [PersonNode].
///
/// Uses [EntityDetailSheet] as the layout shell and injects:
///   - [EntityNameHeader]  — inline-editable name with avatar
///   - [_PersonBasicInfoSection] — gender / taste / MBTI / vehicle chips
///   - [DetailSection] for preference tags
///   - [EntityAddTagSection] with a sentiment selector
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

    return EntityDetailSheet(
      onDelete: () =>
          ref.read(personsProvider.notifier).delete(widget.personId),
      header: EntityNameHeader(
        avatar: CircleAvatar(
          radius: 24,
          backgroundColor: avatarColor(person.name),
          child: Text(
            person.name.isNotEmpty ? person.name[0] : '?',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        name: person.name,
        onSave: (name) => ref.read(personsProvider.notifier).upsert(
              person.copyWith(name: name, updatedAt: DateTime.now()),
            ),
      ),
      sections: [
        _PersonBasicInfoSection(person: person),
        DetailSection(
          title: '偏好标签',
          child: tagsAsync.when(
            loading: () => const SizedBox(
                height: 32,
                child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2))),
            error: (e, _) =>
                Text('$e', style: const TextStyle(color: Colors.red)),
            data: (tags) {
              final prefTags =
                  tags.where((t) => t.context != _tasteContext).toList();
              if (prefTags.isEmpty) {
                return Text('还没有偏好标签',
                    style: TextStyle(color: Colors.grey.shade400));
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: prefTags
                    .map((tag) => _PersonTagChip(
                          tag: tag,
                          onDelete: () => ref
                              .read(personTagsProvider(widget.personId)
                                  .notifier)
                              .removeTag(tag.id),
                        ))
                    .toList(),
              );
            },
          ),
        ),
        EntityAddTagSection(
          controller: _tagController,
          hint: '例：不喜欢嘈杂的地方、爱吃日料',
          onSubmit: _submitTag,
          extra: _SentimentSelector(
            value: _sentiment,
            onChanged: (s) => setState(() => _sentiment = s),
          ),
        ),
      ],
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

// ── Person-specific sections ──────────────────────────────────────────────────

/// Basic-info chips: gender, taste, MBTI, vehicle.
class _PersonBasicInfoSection extends ConsumerWidget {
  final PersonNode person;
  const _PersonBasicInfoSection({required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(personTagsProvider(person.id)).valueOrNull ?? [];
    final tasteTag = tags.firstWhereOrNull((t) => t.context == _tasteContext);

    return DetailSection(
      title: '基本信息',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          DetailInfoChip(
            icon: Icons.person_outline,
            label: person.gender?.isNotEmpty == true
                ? '性别：${person.gender}'
                : '性别未填',
            onTap: () => showEditTextDialog(
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
          DetailInfoChip(
            icon: Icons.restaurant_outlined,
            label: tasteTag != null ? '口味：${tasteTag.label}' : '口味未填',
            onTap: () => _editTaste(context, ref, tasteTag),
          ),
          DetailInfoChip(
            icon: Icons.psychology_outlined,
            label: person.mbti?.isNotEmpty == true
                ? 'MBTI：${person.mbti}'
                : 'MBTI未填',
            onTap: () => showEditTextDialog(
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
          DetailInfoChip(
            icon: Icons.directions_car_outlined,
            label: person.hasVehicle
                ? '有车（${person.vehicleSeats ?? '?'}座）'
                : '无车',
            onTap: () => _editVehicle(context, ref),
          ),
        ],
      ),
    );
  }

  void _editTaste(
      BuildContext context, WidgetRef ref, PreferenceTag? existing) {
    final ctrl = TextEditingController(text: existing?.label ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('口味偏好'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hint: Text('例：不吃辣，喜欢清淡')),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              final value = ctrl.text.trim();
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

  void _editVehicle(BuildContext context, WidgetRef ref) {
    final seatsCtrl =
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
                  controller: seatsCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '座位数'),
                ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('取消')),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ref.read(personsProvider.notifier).upsert(
                      person.copyWith(
                        hasVehicle: hasVehicle,
                        vehicleSeats:
                            hasVehicle ? int.tryParse(seatsCtrl.text) : null,
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
}

// ── Person-specific tag chips ─────────────────────────────────────────────────

class _SentimentSelector extends StatelessWidget {
  final TagSentiment value;
  final ValueChanged<TagSentiment> onChanged;

  const _SentimentSelector(
      {required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TagSentiment.values.map((s) {
        final selected = value == s;
        final color = _sentimentColor(s);
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(_sentimentLabel(s)),
            selected: selected,
            selectedColor: color.withValues(alpha: 0.25),
            labelStyle: TextStyle(
              color: selected ? color : null,
              fontWeight:
                  selected ? FontWeight.w600 : FontWeight.normal,
            ),
            onSelected: (_) => onChanged(s),
          ),
        );
      }).toList(),
    );
  }
}

class _PersonTagChip extends StatelessWidget {
  final PreferenceTag tag;
  final VoidCallback onDelete;

  const _PersonTagChip({required this.tag, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final color = _sentimentColor(tag.sentiment);
    return Chip(
      label: Text(tag.label),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
      deleteIcon: Icon(Icons.close, size: 15, color: color),
      onDeleted: onDelete,
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

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
