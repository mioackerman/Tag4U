import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:tag4u/presentation/widgets/person_detail_sheet.dart';
import 'package:uuid/uuid.dart';

class PersonsPage extends ConsumerStatefulWidget {
  const PersonsPage({super.key});

  @override
  ConsumerState<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends ConsumerState<PersonsPage> {
  bool _isSelecting = false;
  final Set<String> _sel = {};

  // ── Selection helpers ──────────────────────────────────────────────────────

  void _startSelect(String id) {
    setState(() {
      _isSelecting = true;
      _sel.add(id);
    });
  }

  void _toggleSelect(String id) {
    setState(() {
      if (!_sel.remove(id)) _sel.add(id);
    });
  }

  void _exitSelect() {
    setState(() {
      _isSelecting = false;
      _sel.clear();
    });
  }

  Future<void> _deleteSelected() async {
    final count = _sel.length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除 $count 个人物？'),
        content: const Text('此操作不可撤销。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade400),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final ids = Set<String>.from(_sel);
    for (final id in ids) {
      await ref.read(personsProvider.notifier).delete(id);
    }
    _exitSelect();
  }

  // ── Navigation helpers ─────────────────────────────────────────────────────

  void _showDetail(BuildContext context, String personId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => PersonDetailSheet(personId: personId),
    );
  }

  void _showAddDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加人物'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: '名字',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _submitAdd(ctx, ctrl),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => _submitAdd(ctx, ctrl),
              child: const Text('添加')),
        ],
      ),
    );
  }

  void _submitAdd(BuildContext ctx, TextEditingController ctrl) {
    final name = ctrl.text.trim();
    if (name.isEmpty) return;
    final now = DateTime.now();
    ref.read(personsProvider.notifier).upsert(
          PersonNode(
              id: const Uuid().v4(),
              name: name,
              createdAt: now,
              updatedAt: now),
        );
    Navigator.pop(ctx);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.watch(personsProvider);

    return PopScope(
      canPop: !_isSelecting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exitSelect();
      },
      child: Scaffold(
        appBar: _isSelecting
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _exitSelect,
                ),
                title: Text('已选 ${_sel.length} 项'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red.shade400,
                    tooltip: '批量删除',
                    onPressed: _sel.isNotEmpty ? _deleteSelected : null,
                  ),
                ],
              )
            : AppBar(
                title: const Text('人物'),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_outlined),
                    tooltip: '多选',
                    onPressed: () =>
                        setState(() => _isSelecting = true),
                  ),
                ],
              ),
        body: personsAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('错误：$e')),
          data: (persons) => persons.isEmpty
              ? _EmptyState(onAdd: _showAddDialog)
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: persons.length,
                  itemBuilder: (ctx, i) {
                    final p = persons[i];
                    final isSelected = _sel.contains(p.id);
                    return GestureDetector(
                      onLongPress: _isSelecting
                          ? null
                          : () => _startSelect(p.id),
                      child: Stack(
                        children: [
                          PersonCard(
                            person: p,
                            onTap: _isSelecting
                                ? () => _toggleSelect(p.id)
                                : () => _showDetail(ctx, p.id),
                          ),
                          if (_isSelecting)
                            Positioned(
                              top: 6,
                              right: 6,
                              child: _SelectionBadge(
                                  isSelected: isSelected),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: _isSelecting
            ? null
            : FloatingActionButton(
                onPressed: _showAddDialog,
                tooltip: '添加人物',
                child: const Icon(Icons.person_add_outlined),
              ),
      ),
    );
  }
}

// ── Widgets ────────────────────────────────────────────────────────────────────

class _SelectionBadge extends StatelessWidget {
  final bool isSelected;
  const _SelectionBadge({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? primary : Colors.white.withValues(alpha: 0.9),
        border: Border.all(color: primary, width: 2),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_outline, size: 72, color: Colors.grey),
          const SizedBox(height: 16),
          Text('还没有人物',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            '点击右下角 + 开始添加',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: onAdd,
            child: const Text('添加第一个人物'),
          ),
        ],
      ),
    );
  }
}
