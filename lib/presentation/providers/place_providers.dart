import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
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

/// Derives a single place by id from the cached list. Null if not found.
final placeByIdProvider = Provider.family<PlaceNode?, String>((ref, id) {
  try {
    return ref
        .watch(placesProvider)
        .valueOrNull
        ?.firstWhere((p) => p.id == id);
  } catch (_) {
    return null;
  }
});

// ── Descriptors for a specific place ─────────────────────────────────────────

final placeDescriptorsProvider = AsyncNotifierProviderFamily<
    PlaceDescriptorsNotifier,
    List<SemanticDescriptor>,
    String>(PlaceDescriptorsNotifier.new);

class PlaceDescriptorsNotifier
    extends FamilyAsyncNotifier<List<SemanticDescriptor>, String> {
  @override
  Future<List<SemanticDescriptor>> build(String placeNodeId) async {
    final result = await ref
        .watch(placeRepositoryProvider)
        .getDescriptorsForPlace(placeNodeId);
    return result.fold((f) => throw Exception(f.message), (v) => v);
  }

  Future<void> addDescriptor(SemanticDescriptor descriptor) async {
    await ref.read(placeRepositoryProvider).upsertDescriptor(descriptor);
    ref.invalidateSelf();
  }

  Future<void> removeDescriptor(String descriptorId) async {
    await ref.read(placeRepositoryProvider).deleteDescriptor(descriptorId);
    ref.invalidateSelf();
  }
}
