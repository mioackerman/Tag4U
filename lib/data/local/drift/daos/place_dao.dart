import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/local/drift/tables/places_table.dart';
import 'package:tag4u/data/local/drift/tables/semantic_descriptors_table.dart';

part 'place_dao.g.dart';

@DriftAccessor(tables: [PlacesTable, SemanticDescriptorsTable])
class PlaceDao extends DatabaseAccessor<AppDatabase> with _$PlaceDaoMixin {
  PlaceDao(super.db);

  // --- Places ---

  Future<List<PlacesTableData>> getAllPlaces() => select(placesTable).get();

  Future<List<PlacesTableData>> getPlacesByCategory(String category) =>
      (select(placesTable)..where((t) => t.category.equals(category))).get();

  Future<PlacesTableData?> getPlaceById(String id) =>
      (select(placesTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<PlacesTableData?> getPlaceByExternalId(String externalId) =>
      (select(placesTable)..where((t) => t.externalId.equals(externalId)))
          .getSingleOrNull();

  /// Bounding-box proximity search (fast, no trigonometry).
  /// The [RecommendationPipeline] applies Haversine filtering post-query.
  Future<List<PlacesTableData>> getPlacesNearby({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) =>
      (select(placesTable)
            ..where((t) =>
                t.latitude.isBiggerOrEqualValue(minLat) &
                t.latitude.isSmallerOrEqualValue(maxLat) &
                t.longitude.isBiggerOrEqualValue(minLng) &
                t.longitude.isSmallerOrEqualValue(maxLng)))
          .get();

  Future<void> upsertPlace(PlacesTableCompanion companion) =>
      into(placesTable).insertOnConflictUpdate(companion);

  Future<int> deletePlace(String id) =>
      (delete(placesTable)..where((t) => t.id.equals(id))).go();

  // --- Semantic Descriptors ---

  Future<List<SemanticDescriptorsTableData>> getDescriptorsForPlace(
    String placeNodeId,
  ) =>
      (select(semanticDescriptorsTable)
            ..where((t) => t.placeNodeId.equals(placeNodeId)))
          .get();

  Future<void> upsertDescriptor(SemanticDescriptorsTableCompanion companion) =>
      into(semanticDescriptorsTable).insertOnConflictUpdate(companion);

  Future<int> deleteDescriptor(String id) =>
      (delete(semanticDescriptorsTable)..where((t) => t.id.equals(id))).go();

  Future<int> deleteDescriptorsForPlace(String placeNodeId) =>
      (delete(semanticDescriptorsTable)
            ..where((t) => t.placeNodeId.equals(placeNodeId)))
          .go();
}
