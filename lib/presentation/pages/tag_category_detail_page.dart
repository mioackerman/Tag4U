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
import 'package:uuid/uuid.dart';

class TagCategoryDetailPage extends ConsumerWidget {
  final TagCategory category;
  const TagCategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        centerTitle: false,
      ),
      body: switch (category.type) {
        TagCategoryType.friends => _FriendsList(
            onAdd: () => _showAddPersonDialog(context, ref),
          ),
        TagCategoryType.restaurants => _RestaurantsList(
            onAdd: () => _showAddPlaceDialog(context, ref),
          ),
        TagCategoryType.custom => _CustomEmptyState(name: category.name),
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => switch (category.type) {
          TagCategoryType.friends => _showAddPersonDialog(context, ref),
          TagCategoryType.restaurants => _showAddPlaceDialog(context, ref),
          TagCategoryType.custom => _showAddPersonDialog(context, ref),
        },
        tooltip: '添加',
        child: const Icon(Icons.add),
      ),
    );
  }

  // ── Add person ──────────────────────────────────────────────────────────────

  void _showAddPersonDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加联系人'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration:
              const InputDecoration(hintText: '名字', border: OutlineInputBorder()),
          onSubmitted: (_) => _submitPerson(ctx, ref, ctrl),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
              onPressed: () => _submitPerson(ctx, ref, ctrl),
              child: const Text('添加')),
        ],
      ),
    );
  }

  void _submitPerson(
      BuildContext ctx, WidgetRef ref, TextEditingController c) {
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

  // ── Add restaurant ──────────────────────────────────────────────────────────

  void _showAddPlaceDialog(BuildContext context, WidgetRef ref) {
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
              onPressed: () => _submitPlace(ctx, ref, nameCtrl, addrCtrl),
              child: const Text('添加')),
        ],
      ),
    );
  }

  void _submitPlace(BuildContext ctx, WidgetRef ref,
      TextEditingController nameCtrl, TextEditingController addrCtrl) {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) return;
    final addr =
        addrCtrl.text.trim().isEmpty ? null : addrCtrl.text.trim();
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
}

// ── Friends list ──────────────────────────────────────────────────────────────

class _FriendsList extends ConsumerWidget {
  final VoidCallback onAdd;
  const _FriendsList({required this.onAdd});

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
            onTap: () => showModalBottomSheet(
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
          ),
        );
        return _AlphabetListView(items: items);
      },
    );
  }
}

// ── Restaurants list ──────────────────────────────────────────────────────────

class _RestaurantsList extends ConsumerWidget {
  final VoidCallback onAdd;
  const _RestaurantsList({required this.onAdd});

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
          itemBuilder: (p) => _PlaceListItem(place: p),
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
      child: Text('$name — 暂无内容',
          style: TextStyle(color: Colors.grey.shade400)),
    );
  }
}

// ── Alphabet list builder ─────────────────────────────────────────────────────

class _AlphabetItem {
  final String? letter;
  final Widget? child;

  const _AlphabetItem.header(String l) : letter = l, child = null;
  const _AlphabetItem.item(Widget w) : letter = null, child = w;

  bool get isHeader => letter != null;
}

List<_AlphabetItem> _buildAlphabetItems<T>(
  List<T> items, {
  required String Function(T) getName,
  required Widget Function(T) itemBuilder,
}) {
  final sorted = List<T>.from(items)
    ..sort((a, b) =>
        getName(a).toLowerCase().compareTo(getName(b).toLowerCase()));

  final result = <_AlphabetItem>[];
  String? lastLetter;

  for (final item in sorted) {
    final name = getName(item);
    final firstChar = name.isNotEmpty ? name[0].toUpperCase() : '#';
    final letter =
        RegExp(r'[A-Z]').hasMatch(firstChar) ? firstChar : '#';
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
                .withOpacity(0.5),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
  final VoidCallback onTap;
  const _PersonListItem({required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = avatarColor(person.name);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          person.name.isNotEmpty ? person.name[0] : '?',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(person.name,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}

class _PlaceListItem extends StatelessWidget {
  final PlaceNode place;
  const _PlaceListItem({required this.place});

  @override
  Widget build(BuildContext context) {
    final color = placeCategoryColor(place.category);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(placeCategoryIcon(place.category),
            color: Colors.white, size: 20),
      ),
      title: Text(place.name,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: place.address != null
          ? Text(place.address!,
              maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
    );
  }
}

// ── Helper ─────────────────────────────────────────────────────────────────────

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
