import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';

abstract class IPlaceRepository {
  ResultFuture<List<PlaceNode>> getPlaces({PlaceCategory? category, String? city});

  ResultFuture<PlaceNode?> getPlaceById(String id);

  /// Search local + remote candidates within [radiusKm] of [lat]/[lng].
  ResultFuture<List<PlaceNode>> searchNearby({
    required double lat,
    required double lng,
    required double radiusKm,
    PlaceCategory? category,
  });

  ResultFuture<PlaceNode> upsertPlace(PlaceNode place);

  ResultFuture<void> deletePlace(String id);

  // --- Semantic Descriptors (two-layer model) ---

  ResultFuture<List<SemanticDescriptor>> getDescriptorsForPlace(String placeNodeId);

  ResultFuture<SemanticDescriptor> upsertDescriptor(SemanticDescriptor descriptor);

  ResultFuture<void> deleteDescriptor(String descriptorId);

  /// Fetches and stores public semantic descriptors from an external source
  /// (e.g. Google Places AI summary, web crawl).
  ResultFuture<List<SemanticDescriptor>> refreshPublicDescriptors(String placeNodeId);
}
