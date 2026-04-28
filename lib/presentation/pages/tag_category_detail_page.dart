import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/tag_category.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:tag4u/presentation/widgets/person_detail_sheet.dart';
import 'package:tag4u/presentation/widgets/place_card.dart';
import 'package:tag4u/presentation/widgets/place_detail_sheet.dart';
import 'package:uuid/uuid.dart';

class TagCategoryDetailPage extends ConsumerStatefulWidget {
  final TagCategory category;
  const TagCategoryDetailPage({super.key, required this.category});

  @override
  ConsumerState<TagCategoryDetailPage> createState() =>
      _TagCategoryDetailPageState();
}

class _TagCategoryDetailPageState extends ConsumerState<TagCategoryDetailPage> {
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
        title: Text('删除 $count 项？'),
        content: const Text('此操作不可撤销。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade400),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final ids = Set<String>.from(_sel);
    switch (widget.category.type) {
      case TagCategoryType.friends:
      case TagCategoryType.custom:
        for (final id in ids) {
          await ref.read(personsProvider.notifier).delete(id);
        }
      case TagCategoryType.restaurants:
        for (final id in ids) {
          await ref.read(placesProvider.notifier).delete(id);
        }
    }
    _exitSelect();
  }

  // ── Add helpers ────────────────────────────────────────────────────────────

  void _showAddPersonDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add tags set'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
              hintText: '名字', border: OutlineInputBorder()),
          onSubmitted: (_) => _submitPerson(ctx, ctrl),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => _submitPerson(ctx, ctrl),
              child: const Text('添加')),
        ],
      ),
    );
  }

  void _submitPerson(BuildContext ctx, TextEditingController c) {
    final name = c.text.trim();
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

  void _showAddPlaceDialog() {
    final nameCtrl = TextEditingController();
    final addrCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加餐厅'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: '餐厅名称', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addrCtrl,
              decoration: const InputDecoration(
                  labelText: '地址（选填）', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => _submitPlace(ctx, nameCtrl, addrCtrl),
              child: const Text('添加')),
        ],
      ),
    );
  }

  void _submitPlace(BuildContext ctx, TextEditingController nameCtrl,
      TextEditingController addrCtrl) {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) return;
    final addr = addrCtrl.text.trim().isEmpty ? null : addrCtrl.text.trim();
    final now = DateTime.now();
    ref.read(placesProvider.notifier).upsert(
          PlaceNode(
            id: const Uuid().v4(),
            name: name,
            address: addr,
            category: PlaceCategory.restaurant,
            layer: PlaceLayer.personal,
            createdAt: now,
            updatedAt: now,
          ),
        );
    Navigator.pop(ctx);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  VoidCallback get _onAdd => switch (widget.category.type) {
        TagCategoryType.friends => _showAddPersonDialog,
        TagCategoryType.restaurants => _showAddPlaceDialog,
        TagCategoryType.custom => _showAddPersonDialog,
      };

  @override
  Widget build(BuildContext context) {
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
                title: Text(widget.category.name),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.checklist_outlined),
                    tooltip: '多选',
                    onPressed: () => setState(() => _isSelecting = true),
                  ),
                ],
              ),
        body: switch (widget.category.type) {
          TagCategoryType.friends => _FriendsList(
              isSelecting: _isSelecting,
              selectedIds: _sel,
              onToggle: _toggleSelect,
              onStartSelect: _startSelect,
              onAdd: _onAdd,
            ),
          TagCategoryType.restaurants => _RestaurantsList(
              isSelecting: _isSelecting,
              selectedIds: _sel,
              onToggle: _toggleSelect,
              onStartSelect: _startSelect,
              onAdd: _onAdd,
            ),
          TagCategoryType.custom =>
            _CustomEmptyState(name: widget.category.name),
        },
        floatingActionButton: _isSelecting
            ? null
            : FloatingActionButton(
                onPressed: _onAdd,
                tooltip: '添加',
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}

// ── Friends list ──────────────────────────────────────────────────────────────

class _FriendsList extends ConsumerWidget {
  final bool isSelecting;
  final Set<String> selectedIds;
  final void Function(String) onToggle;
  final void Function(String) onStartSelect;
  final VoidCallback onAdd;

  const _FriendsList({
    required this.isSelecting,
    required this.selectedIds,
    required this.onToggle,
    required this.onStartSelect,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);

    return personsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (persons) {
        if (persons.isEmpty) {
          return _EmptyHint(message: '还没有联系人', onAdd: onAdd);
        }
        final items = _buildAlphabetItems<PersonNode>(
          persons,
          getName: (p) => p.name,
          itemBuilder: (p) => _PersonListItem(
            person: p,
            isSelecting: isSelecting,
            isSelected: selectedIds.contains(p.id),
            onTap: isSelecting
                ? () => onToggle(p.id)
                : () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => PersonDetailSheet(personId: p.id),
                    ),
            onLongPress: isSelecting ? null : () => onStartSelect(p.id),
          ),
        );
        return _AlphabetListView(items: items);
      },
    );
  }
}

// ── Restaurants list ──────────────────────────────────────────────────────────

class _RestaurantsList extends ConsumerWidget {
  final bool isSelecting;
  final Set<String> selectedIds;
  final void Function(String) onToggle;
  final void Function(String) onStartSelect;
  final VoidCallback onAdd;

  const _RestaurantsList({
    required this.isSelecting,
    required this.selectedIds,
    required this.onToggle,
    required this.onStartSelect,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (places) {
        final restaurants = places
            .where((p) => p.category == PlaceCategory.restaurant)
            .toList();
        if (restaurants.isEmpty) {
          return _EmptyHint(message: '还没有餐厅', onAdd: onAdd);
        }
        final items = _buildAlphabetItems<PlaceNode>(
          restaurants,
          getName: (p) => p.name,
          itemBuilder: (p) => _PlaceListItem(
            place: p,
            isSelecting: isSelecting,
            isSelected: selectedIds.contains(p.id),
            onTap: isSelecting
                ? () => onToggle(p.id)
                : () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => PlaceDetailSheet(placeId: p.id),
                    ),
            onLongPress: isSelecting ? null : () => onStartSelect(p.id),
          ),
        );
        return _AlphabetListView(items: items);
      },
    );
  }
}

// ── Custom empty ──────────────────────────────────────────────────────────────

class _CustomEmptyState extends StatelessWidget {
  final String name;
  const _CustomEmptyState({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Text('$name — 暂无内容', style: TextStyle(color: Colors.grey.shade400)),
    );
  }
}

// ── Alphabet list builder ─────────────────────────────────────────────────────

class _AlphabetItem {
  final String? letter;
  final Widget? child;

  const _AlphabetItem.header(String l)
      : letter = l,
        child = null;
  const _AlphabetItem.item(Widget w)
      : letter = null,
        child = w;

  bool get isHeader => letter != null;
}

List<_AlphabetItem> _buildAlphabetItems<T>(
  List<T> items, {
  required String Function(T) getName,
  required Widget Function(T) itemBuilder,
}) {
  final sorted = List<T>.from(items)
    ..sort(
        (a, b) => getName(a).toLowerCase().compareTo(getName(b).toLowerCase()));

  final result = <_AlphabetItem>[];
  String? lastLetter;

  for (final item in sorted) {
    final name = getName(item);
    final firstChar = name.isNotEmpty ? name[0].toUpperCase() : '#';
    final letter = RegExp(r'[A-Z]').hasMatch(firstChar) ? firstChar : '#';
    if (letter != lastLetter) {
      result.add(_AlphabetItem.header(letter));
      lastLetter = letter;
    }
    result.add(_AlphabetItem.item(itemBuilder(item)));
  }

  return result;
}

class _AlphabetListView extends StatelessWidget {
  final List<_AlphabetItem> items;
  const _AlphabetListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        if (item.isHeader) {
          return Container(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              item.letter!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
        return item.child!;
      },
    );
  }
}

// ── List item widgets ─────────────────────────────────────────────────────────

class _PersonListItem extends StatelessWidget {
  final PersonNode person;
  final bool isSelecting;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _PersonListItem({
    required this.person,
    required this.isSelecting,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = avatarColor(person.name);
    final avatar = CircleAvatar(
      backgroundColor: color,
      child: Text(
        person.name.isNotEmpty ? person.name[0] : '?',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );

    if (isSelecting) {
      return CheckboxListTile(
        value: isSelected,
        onChanged: (_) => onTap(),
        secondary: avatar,
        title: Text(person.name,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        controlAffinity: ListTileControlAffinity.trailing,
      );
    }
    return ListTile(
      leading: avatar,
      title: Text(person.name,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class _PlaceListItem extends StatelessWidget {
  final PlaceNode place;
  final bool isSelecting;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _PlaceListItem({
    required this.place,
    required this.isSelecting,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = placeCategoryColor(place.category);
    final avatar = CircleAvatar(
      backgroundColor: color,
      child: Icon(placeCategoryIcon(place.category),
          color: Colors.white, size: 20),
    );

    if (isSelecting) {
      return CheckboxListTile(
        value: isSelected,
        onChanged: (_) => onTap(),
        secondary: avatar,
        title: Text(place.name,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: place.address != null
            ? Text(place.address!, maxLines: 1, overflow: TextOverflow.ellipsis)
            : null,
        controlAffinity: ListTileControlAffinity.trailing,
      );
    }
    return ListTile(
      leading: avatar,
      title:
          Text(place.name, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: place.address != null
          ? Text(place.address!, maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

// ── Helper ────────────────────────────────────────────────────────────────────

class _EmptyHint extends StatelessWidget {
  final String message;
  final VoidCallback onAdd;
  const _EmptyHint({required this.message, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: TextStyle(color: Colors.grey.shade400)),
          const SizedBox(height: 16),
          FilledButton.tonal(onPressed: onAdd, child: const Text('添加')),
        ],
      ),
    );
  }
}
