import 'dart:math' as math;
import 'package:dartz/dartz.dart';
import 'package:tag4u/core/constants/app_constants.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/data/local/drift/daos/place_dao.dart';
import 'package:tag4u/data/local/drift/mappers/place_mapper.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/domain/repositories/i_place_repository.dart';

class PlaceRepositoryImpl implements IPlaceRepository {
  final PlaceDao _dao;

  const PlaceRepositoryImpl({required PlaceDao dao}) : _dao = dao;

  @override
  ResultFuture<List<PlaceNode>> getPlaces({
    PlaceCategory? category,
    String? city,
  }) async {
    try {
      final rows = category != null
          ? await _dao.getPlacesByCategory(category.name)
          : await _dao.getAllPlaces();
      var places = rows.map((r) => r.toDomain()).toList();
      if (city != null) {
        places = places.where((p) => p.city == city).toList();
      }
      return Right(places);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PlaceNode?> getPlaceById(String id) async {
    try {
      final row = await _dao.getPlaceById(id);
      return Right(row?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<PlaceNode>> searchNearby({
    required double lat,
    required double lng,
    required double radiusKm,
    PlaceCategory? category,
  }) async {
    try {
      // Bounding box approximation (~1 degree ≈ 111 km)
      final deltaLat = radiusKm / 111.0;
      final deltaLng = radiusKm / (111.0 * math.cos(lat * math.pi / 180));

      final rows = await _dao.getPlacesNearby(
        minLat: lat - deltaLat,
        maxLat: lat + deltaLat,
        minLng: lng - deltaLng,
        maxLng: lng + deltaLng,
      );

      var places = rows.map((r) => r.toDomain()).toList();

      // Haversine precise filter
      places = places.where((p) {
        if (p.latitude == null || p.longitude == null) return false;
        return _haversineKm(lat, lng, p.latitude!, p.longitude!) <= radiusKm;
      }).toList();

      if (category != null) {
        places = places.where((p) => p.category == category).toList();
      }

      // Limit candidates
      if (places.length > AppConstants.maxCandidatePlaces) {
        places = places.sublist(0, AppConstants.maxCandidatePlaces);
      }

      return Right(places);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PlaceNode> upsertPlace(PlaceNode place) async {
    try {
      await _dao.upsertPlace(place.toCompanion());
      return Right(place);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deletePlace(String id) async {
    try {
      await _dao.deletePlace(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<SemanticDescriptor>> getDescriptorsForPlace(
    String placeNodeId,
  ) async {
    try {
      final rows = await _dao.getDescriptorsForPlace(placeNodeId);
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<SemanticDescriptor> upsertDescriptor(
    SemanticDescriptor descriptor,
  ) async {
    try {
      await _dao.upsertDescriptor(descriptor.toCompanion());
      return Right(descriptor);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteDescriptor(String descriptorId) async {
    try {
      await _dao.deleteDescriptor(descriptorId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<SemanticDescriptor>> refreshPublicDescriptors(
    String placeNodeId,
  ) async {
    // TODO: Integrate with external places API (Google Places / Yelp).
    // This stub clears old AI-generated descriptors and returns empty list.
    try {
      await _dao.deleteDescriptorsForPlace(placeNodeId);
      return const Right([]);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  // --- Helpers ---

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
