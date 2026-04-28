import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';

/// Bottom sheet for selecting planning participants.
///
/// Returns `Set<String>` (selected person IDs) via [Navigator.pop]
/// when the user taps "下一步", or `null` if dismissed.
class PartyInputSheet extends ConsumerStatefulWidget {
  final Set<String> initialSelectedIds;

  const PartyInputSheet({super.key, this.initialSelectedIds = const {}});

  @override
  ConsumerState<PartyInputSheet> createState() => _PartyInputSheetState();
}

class _PartyInputSheetState extends ConsumerState<PartyInputSheet> {
  late final Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set.from(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.watch(personsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          _Handle(),

          // ── Header ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '选择参与人员',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (_selectedIds.isNotEmpty)
                  Text(
                    '已选 ${_selectedIds.length} 人',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary),
                  ),
              ],
            ),
          ),

          // ── Person list ──────────────────────────────────────────────
          Expanded(
            child: personsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (persons) {
                if (persons.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '还没有联系人，先去 Tag 页面添加吧',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  );
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: persons.length,
                  itemBuilder: (context, i) {
                    final p = persons[i];
                    final selected = _selectedIds.contains(p.id);
                    final color = avatarColor(p.name);
                    return CheckboxListTile(
                      value: selected,
                      onChanged: (_) => setState(() {
                        if (selected) {
                          _selectedIds.remove(p.id);
                        } else {
                          _selectedIds.add(p.id);
                        }
                      }),
                      title: Text(p.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500)),
                      secondary: CircleAvatar(
                        backgroundColor: color,
                        child: Text(
                          p.name.isNotEmpty ? p.name[0] : '?',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    );
                  },
                );
              },
            ),
          ),

          // ── 下一步 button ─────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: FilledButton(
                onPressed: () => Navigator.pop(context, _selectedIds),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('下一步', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

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
