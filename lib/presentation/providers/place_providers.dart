import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';

// ── Place list ────────────────────────────────────────────────────────────────

final placesProvider =
    AsyncNotifierProvider<PlacesNotifier, List<PlaceNode>>(PlacesNotifier.new);

class PlacesNotifier extends AsyncNotifier<List<PlaceNode>> {
  @override
  Future<List<PlaceNode>> build() async {
    final result = await ref.watch(placeRepositoryProvider).getPlaces();
    return result.fold((f) => throw Exception(f.message), (v) => v);
  }

  Future<void> upsert(PlaceNode place) async {
    await ref.read(placeRepositoryProvider).upsertPlace(place);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    await ref.read(placeRepositoryProvider).deletePlace(id);
    ref.invalidateSelf();
  }
}

/// Derives places filtered to a specific category from the cached list.
final placesByCategoryProvider =
    Provider.family<List<PlaceNode>, PlaceCategory>((ref, cat) {
  return ref.watch(placesProvider).valueOrNull
          ?.where((p) => p.category == cat)
          .toList() ??
      [];
});
