import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/providers/planning_chat_provider.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';

/// Bottom sheet for collecting party-planning input:
///   1. Select participants from stored person cards.
///   2. Free-text description of the activity.
class PartyInputSheet extends ConsumerStatefulWidget {
  const PartyInputSheet({super.key});

  @override
  ConsumerState<PartyInputSheet> createState() => _PartyInputSheetState();
}

class _PartyInputSheetState extends ConsumerState<PartyInputSheet> {
  final _descController = TextEditingController();
  final _selectedIds = <String>{};

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.watch(personsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          children: [
            _Handle(),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding:
                    const EdgeInsets.fromLTRB(20, 4, 20, 48),
                children: [
                  _SectionLabel(text: '选择参与人员'),
                  const SizedBox(height: 12),
                  personsAsync.when(
                    loading: () => const Center(
                        child: CircularProgressIndicator()),
                    error: (e, _) => Text('$e'),
                    data: (persons) => persons.isEmpty
                        ? _NoPersonsHint()
                        : _PersonGrid(
                            persons: persons,
                            selectedIds: _selectedIds,
                            onToggle: (id) => setState(() {
                              if (_selectedIds.contains(id)) {
                                _selectedIds.remove(id);
                              } else {
                                _selectedIds.add(id);
                              }
                            }),
                          ),
                  ),
                  const SizedBox(height: 24),
                  _SectionLabel(text: '描述一下活动'),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descController,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '例：周末下午找个安静的地方喝茶聊天',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _canSubmit() ? _submit : null,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('开始规划',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  bool _canSubmit() =>
      _descController.text.trim().isNotEmpty;

  Future<void> _submit() async {
    final persons = ref.read(personsProvider).valueOrNull ?? [];
    final selected = persons
        .where((p) => _selectedIds.contains(p.id))
        .toList();

    // Gather tags for each selected person
    final tagsByPerson = <String, List<PreferenceTag>>{};
    for (final p in selected) {
      final tags =
          ref.read(personTagsProvider(p.id)).valueOrNull ?? [];
      tagsByPerson[p.id] = tags;
    }

    Navigator.pop(context); // close sheet before async

    await ref.read(planningChatProvider.notifier).submitPartyPlanning(
          members: selected,
          tagsByPerson: tagsByPerson,
          description: _descController.text.trim(),
        );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _PersonGrid extends StatelessWidget {
  final List<PersonNode> persons;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  const _PersonGrid({
    required this.persons,
    required this.selectedIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.78,
      ),
      itemCount: persons.length,
      itemBuilder: (context, i) {
        final p = persons[i];
        final selected = selectedIds.contains(p.id);
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: selected
                    ? Border.all(
                        color:
                            Theme.of(context).colorScheme.primary,
                        width: 2.5)
                    : null,
              ),
              child: PersonCard(
                  person: p, onTap: () => onToggle(p.id)),
            ),
            if (selected)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check,
                      size: 12, color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 0.5,
            ),
      );
}

class _NoPersonsHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          '还没有人物，先去"人物"页面添加吧',
          style: TextStyle(color: Colors.grey.shade400),
        ),
      );
}
