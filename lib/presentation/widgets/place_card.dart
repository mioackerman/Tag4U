import 'package:flutter/material.dart';
import 'package:tag4u/domain/entities/place_node.dart';

class PlaceCard extends StatelessWidget {
  final PlaceNode place;
  final VoidCallback onTap;

  const PlaceCard({super.key, required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = placeCategoryColor(place.category);

    return Material(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color,
                child: Icon(
                  placeCategoryIcon(place.category),
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                place.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              if (place.address != null) ...[
                const SizedBox(height: 2),
                Text(
                  place.address!,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Color placeCategoryColor(PlaceCategory category) => switch (category) {
      PlaceCategory.restaurant => const Color(0xFFEF5350),
      PlaceCategory.cafe => const Color(0xFFFF7043),
      PlaceCategory.bar => const Color(0xFF9C27B0),
      PlaceCategory.park => const Color(0xFF4CAF50),
      PlaceCategory.museum => const Color(0xFF5C6BC0),
      PlaceCategory.cinema => const Color(0xFF26A69A),
      PlaceCategory.shoppingMall => const Color(0xFFEC407A),
      PlaceCategory.outdoorActivity => const Color(0xFF8BC34A),
      PlaceCategory.nightclub => const Color(0xFF7E57C2),
      PlaceCategory.hotel => const Color(0xFF42A5F5),
      PlaceCategory.attraction => const Color(0xFFFFB300),
      PlaceCategory.other => const Color(0xFF78909C),
    };

IconData placeCategoryIcon(PlaceCategory category) => switch (category) {
      PlaceCategory.restaurant => Icons.restaurant,
      PlaceCategory.cafe => Icons.coffee,
      PlaceCategory.bar => Icons.local_bar,
      PlaceCategory.park => Icons.park,
      PlaceCategory.museum => Icons.museum,
      PlaceCategory.cinema => Icons.movie,
      PlaceCategory.shoppingMall => Icons.shopping_bag,
      PlaceCategory.outdoorActivity => Icons.hiking,
      PlaceCategory.nightclub => Icons.nightlife,
      PlaceCategory.hotel => Icons.hotel,
      PlaceCategory.attraction => Icons.place,
      PlaceCategory.other => Icons.location_on,
    };
