import 'dart:math' as math;
import 'package:tag4u/domain/entities/place_node.dart';

/// Applies deterministic hard constraints to a candidate place list.
///
/// All hard filters are rule-based — no LLM involved.
/// Constraints: distance, budget level, category allowlist/blocklist.
class HardConstraintEngine {
  const HardConstraintEngine();

  /// Filters [candidates] against hard constraints.
  ///
  /// [lat]/[lng] — user's current position.
  /// [radiusKm]  — maximum allowed distance.
  /// [maxBudgetLevel] — 1-4 Google-style price level ceiling.
  /// [allowedCategories] — if non-null, only these categories pass.
  /// [blockedCategories] — always excluded regardless of other criteria.
  List<PlaceNode> filter({
    required List<PlaceNode> candidates,
    required double lat,
    required double lng,
    double radiusKm = 10.0,
    int? maxBudgetLevel,
    Set<PlaceCategory>? allowedCategories,
    Set<PlaceCategory> blockedCategories = const {},
  }) {
    return candidates.where((place) {
      // Distance constraint
      if (place.latitude != null && place.longitude != null) {
        final dist = _haversineKm(lat, lng, place.latitude!, place.longitude!);
        if (dist > radiusKm) return false;
      }

      // Budget constraint
      if (maxBudgetLevel != null && place.priceLevel != null) {
        if (place.priceLevel! > maxBudgetLevel) return false;
      }

      // Category constraints
      if (blockedCategories.contains(place.category)) return false;
      if (allowedCategories != null &&
          !allowedCategories.contains(place.category)) return false;

      return true;
    }).toList();
  }

  /// Checks whether a single place satisfies all hard constraints.
  bool passes(
    PlaceNode place, {
    required double lat,
    required double lng,
    double radiusKm = 10.0,
    int? maxBudgetLevel,
  }) {
    return filter(
      candidates: [place],
      lat: lat,
      lng: lng,
      radiusKm: radiusKm,
      maxBudgetLevel: maxBudgetLevel,
    ).isNotEmpty;
  }

  static double _haversineKm(
    double lat1, double lng1, double lat2, double lng2,
  ) {
    const r = 6371.0;
    final dLat = _deg2rad(lat2 - lat1);
    final dLng = _deg2rad(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_deg2rad(lat1)) *
            math.cos(_deg2rad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    return r * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  static double _deg2rad(double deg) => deg * math.pi / 180;
}
