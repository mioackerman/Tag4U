import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';
import 'package:tag4u/presentation/widgets/place_card.dart';

/// Full-screen page for selecting places before planning.
///
/// Returns `List<PlaceNode>` via `Navigator.pop`:
///   - Non-empty list → user picked specific places.
///   - Empty list     → user tapped "跳过" (skip).
class PlaceSelectionPage extends ConsumerStatefulWidget {
  final List<PlaceNode> initialSelected;

  const PlaceSelectionPage({super.key, this.initialSelected = const []});

  @override
  ConsumerState<PlaceSelectionPage> createState() =>
      _PlaceSelectionPageState();
}

class _PlaceSelectionPageState extends ConsumerState<PlaceSelectionPage> {
  final _searchController = TextEditingController();
  late final Set<String> _selectedIds;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.initialSelected.map((p) => p.id).toSet();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(placesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('选择地点'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // ── Search bar ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  setState(() => _query = v.trim().toLowerCase()),
              decoration: InputDecoration(
                hintText: '搜索地点…',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.surfaceContainerHigh,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),

          // ── Place list ────────────────────────────────────────────────
          Expanded(
            child: placesAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (places) {
                final filtered = _query.isEmpty
                    ? places
                    : places
                        .where((p) =>
                            p.name.toLowerCase().contains(_query) ||
                            (p.address
                                    ?.toLowerCase()
                                    .contains(_query) ??
                                false))
                        .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      _query.isEmpty
                          ? '还没有地点，先去 Tag 页面的餐厅分类添加吧'
                          : '没有找到"$_query"',
                      style:
                          TextStyle(color: Colors.grey.shade400),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final place = filtered[i];
                    final selected = _selectedIds.contains(place.id);
                    final color = placeCategoryColor(place.category);
                    return CheckboxListTile(
                      value: selected,
                      onChanged: (_) => setState(() {
                        if (selected) {
                          _selectedIds.remove(place.id);
                        } else {
                          _selectedIds.add(place.id);
                        }
                      }),
                      title: Text(place.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500)),
                      subtitle: place.address != null
                          ? Text(place.address!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)
                          : null,
                      secondary: CircleAvatar(
                        backgroundColor: color.withOpacity(0.15),
                        child: Icon(placeCategoryIcon(place.category),
                            color: color, size: 20),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                    );
                  },
                );
              },
            ),
          ),

          // ── Bottom actions ────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pop(context, <PlaceNode>[]),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('跳过'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: _confirm,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(_selectedIds.isEmpty
                          ? '确认'
                          : '确认（${_selectedIds.length}个）'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirm() {
    final allPlaces = ref.read(placesProvider).valueOrNull ?? [];
    final selected =
        allPlaces.where((p) => _selectedIds.contains(p.id)).toList();
    Navigator.pop(context, selected);
  }
}
