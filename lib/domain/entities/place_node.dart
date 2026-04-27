import 'package:equatable/equatable.dart';

enum PlaceCategory {
  restaurant,
  cafe,
  bar,
  park,
  museum,
  cinema,
  shoppingMall,
  outdoorActivity,
  nightclub,
  hotel,
  attraction,
  other,
}

/// Which layer a place's data comes from.
///
/// Public layer: machine-generated / crawled descriptors.
/// Personal layer: user-generated judgments and memories.
enum PlaceLayer { public, personal }

/// A place node in the preference graph.
///
/// Implements the two-layer place model:
///   - Public semantic layer: machine descriptors from external sources.
///   - Personal memory layer: user judgments stored locally.
class PlaceNode extends Equatable {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? city;
  final String? countryCode;
  final PlaceCategory category;

  /// Public layer: external source identifier (e.g. Google Places ID).
  final String? externalId;

  /// Public layer: average price level 1-4 (like Google's price_level).
  final int? priceLevel;

  /// Public layer: aggregate rating.
  final double? publicRating;

  /// Personal layer: user's own notes about this place.
  final String? personalNote;

  /// Personal layer: user's own score (-1.0 to 1.0, negative = dislike).
  final double? personalScore;

  /// Personal layer: timestamp of last visit.
  final DateTime? lastVisitedAt;

  /// Whether this place record was created by the user vs. imported.
  final PlaceLayer layer;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PlaceNode({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.countryCode,
    this.category = PlaceCategory.other,
    this.externalId,
    this.priceLevel,
    this.publicRating,
    this.personalNote,
    this.personalScore,
    this.lastVisitedAt,
    this.layer = PlaceLayer.public,
    required this.createdAt,
    required this.updatedAt,
  });

  PlaceNode copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    String? countryCode,
    PlaceCategory? category,
    String? externalId,
    int? priceLevel,
    double? publicRating,
    String? personalNote,
    double? personalScore,
    DateTime? lastVisitedAt,
    PlaceLayer? layer,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlaceNode(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      countryCode: countryCode ?? this.countryCode,
      category: category ?? this.category,
      externalId: externalId ?? this.externalId,
      priceLevel: priceLevel ?? this.priceLevel,
      publicRating: publicRating ?? this.publicRating,
      personalNote: personalNote ?? this.personalNote,
      personalScore: personalScore ?? this.personalScore,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
      layer: layer ?? this.layer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, name, latitude, longitude, address, city, countryCode,
        category, externalId, priceLevel, publicRating,
        personalNote, personalScore, lastVisitedAt, layer,
        createdAt, updatedAt,
      ];
}
