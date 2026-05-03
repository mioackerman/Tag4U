import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/tag_category.dart';
import 'package:uuid/uuid.dart';

final tagCategoriesProvider =
    NotifierProvider<TagCategoriesNotifier, List<TagCategory>>(
  TagCategoriesNotifier.new,
);

class TagCategoriesNotifier extends Notifier<List<TagCategory>> {
  static const _uuid = Uuid();

  @override
  List<TagCategory> build() {
    return const [
      TagCategory(
          id: 'restaurants', name: '餐厅', type: TagCategoryType.restaurants),
    ];
  }

  void addCustom(String name) {
    if (name.trim().isEmpty) return;
    state = [
      ...state,
      TagCategory(
        id: _uuid.v4(),
        name: name.trim(),
        type: TagCategoryType.custom,
      ),
    ];
  }

  /// The restaurants category cannot be removed.
  void remove(String id) {
    if (id == 'restaurants') return;
    state = state.where((c) => c.id != id).toList();
  }
}
