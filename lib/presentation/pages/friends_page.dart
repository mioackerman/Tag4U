import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/presentation/pages/friend_detail_page.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:uuid/uuid.dart';

class FriendsPage extends ConsumerStatefulWidget {
  const FriendsPage({super.key});

  @override
  ConsumerState<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends ConsumerState<FriendsPage> {
  bool _isSelecting = false;
  final Set<String> _sel = {};

  void _startSelect(String id) => setState(() {
        _isSelecting = true;
        _sel.add(id);
      });

  void _toggleSelect(String id) => setState(() {
        if (!_sel.remove(id)) _sel.add(id);
      });

  void _exitSelect() => setState(() {
        _isSelecting = false;
        _sel.clear();
      });

  Future<void> _deleteSelected() async {
    final count = _sel.length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('删除 $count 位好友？'),
        content: const Text('此操作不可撤销。'),
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
    if (confirmed != true || !mounted) return;
    for (final id in Set<String>.from(_sel)) {
      await ref.read(personsProvider.notifier).delete(id);
    }
    _exitSelect();
  }

  void _showAddDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加好友'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
              hintText: '好友名字', border: OutlineInputBorder()),
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

  @override
  Widget build(BuildContext context) {
    final friendsAsync = ref.watch(friendsProvider);

    return PopScope(
      canPop: !_isSelecting,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exitSelect();
      },
      child: Scaffold(
        appBar: _isSelecting
            ? AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.close), onPressed: _exitSelect),
                title: Text('已选 ${_sel.length} 项'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red.shade400,
                    onPressed: _sel.isNotEmpty ? _deleteSelected : null,
                  ),
                ],
              )
            : AppBar(
                title: const Text('好友'),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_outlined),
                    tooltip: '多选',
                    onPressed: () => setState(() => _isSelecting = true),
                  ),
                ],
              ),
        body: friendsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('错误：$e')),
          data: (friends) => friends.isEmpty
              ? _EmptyState(onAdd: _showAddDialog)
              : _AlphabetList(
                  friends: friends,
                  isSelecting: _isSelecting,
                  selectedIds: _sel,
                  onTap: (p) => _isSelecting
                      ? _toggleSelect(p.id)
                      : _openDetail(context, p.id),
                  onLongPress: (p) =>
                      _isSelecting ? null : _startSelect(p.id),
                ),
        ),
        floatingActionButton: _isSelecting
            ? null
            : FloatingActionButton(
                onPressed: _showAddDialog,
                tooltip: '添加好友',
                child: const Icon(Icons.person_add_outlined),
              ),
      ),
    );
  }

  void _openDetail(BuildContext context, String personId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => FriendDetailPage(personId: personId)),
    );
  }
}

// ── Alphabetical list ─────────────────────────────────────────────────────────

class _AlphabetList extends StatelessWidget {
  final List<PersonNode> friends;
  final bool isSelecting;
  final Set<String> selectedIds;
  final void Function(PersonNode) onTap;
  final void Function(PersonNode)? onLongPress;

  const _AlphabetList({
    required this.friends,
    required this.isSelecting,
    required this.selectedIds,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = List<PersonNode>.from(friends)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    final items = <_ListItem>[];
    String? lastLetter;
    for (final p in sorted) {
      final first = p.name.isNotEmpty ? p.name[0].toUpperCase() : '#';
      final letter = RegExp(r'[A-Z]').hasMatch(first) ? first : '#';
      if (letter != lastLetter) {
        items.add(_ListItem.header(letter));
        lastLetter = letter;
      }
      items.add(_ListItem.person(p));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        if (item.isHeader) {
          return Container(
            color: Theme.of(ctx)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.5),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              item.letter!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Theme.of(ctx).colorScheme.primary,
              ),
            ),
          );
        }
        final p = item.person!;
        final isSelected = selectedIds.contains(p.id);
        final avatar = CircleAvatar(
          backgroundColor: avatarColor(p.name),
          child: Text(
            p.name.isNotEmpty ? p.name[0] : '?',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );

        if (isSelecting) {
          return CheckboxListTile(
            value: isSelected,
            onChanged: (_) => onTap(p),
            secondary: avatar,
            title: Text(p.name,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            controlAffinity: ListTileControlAffinity.trailing,
          );
        }
        return ListTile(
          leading: avatar,
          title: Text(p.name,
              style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.chevron_right,
              size: 18, color: Colors.grey),
          onTap: () => onTap(p),
          onLongPress: () => onLongPress?.call(p),
        );
      },
    );
  }
}

class _ListItem {
  final String? letter;
  final PersonNode? person;

  const _ListItem.header(String l)
      : letter = l,
        person = null;
  const _ListItem.person(PersonNode p)
      : letter = null,
        person = p;

  bool get isHeader => letter != null;
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
          Text('还没有好友',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text('点击右下角 + 开始添加',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
          const SizedBox(height: 24),
          FilledButton.tonal(
              onPressed: onAdd, child: const Text('添加第一位好友')),
        ],
      ),
    );
  }
}
