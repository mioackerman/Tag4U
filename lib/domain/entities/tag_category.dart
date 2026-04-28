import 'package:flutter/material.dart';

enum TagCategoryType { friends, restaurants, custom }

/// A navigation category on the Tag page.
///
/// [friends] — maps to the PersonNode list.
/// [restaurants] — maps to PlaceNode list filtered to restaurant category.
/// [custom] — user-defined label (reserved for future expansion).
class TagCategory {
  final String id;
  final String name;
  final TagCategoryType type;

  const TagCategory({
    required this.id,
    required this.name,
    required this.type,
  });

  IconData get icon => switch (type) {
        TagCategoryType.friends => Icons.people_outline,
        TagCategoryType.restaurants => Icons.restaurant_outlined,
        TagCategoryType.custom => Icons.label_outline,
      };

  Color get color => switch (type) {
        TagCategoryType.friends => const Color(0xFF42A5F5),
        TagCategoryType.restaurants => const Color(0xFFEF5350),
        TagCategoryType.custom => const Color(0xFF66BB6A),
      };
}
