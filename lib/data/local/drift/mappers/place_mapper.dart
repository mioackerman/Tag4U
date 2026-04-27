import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';

extension PlaceMapper on PlacesTableData {
  PlaceNode toDomain() {
    return PlaceNode(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      address: address,
      city: city,
      countryCode: countryCode,
      category: PlaceCategory.values.firstWhere(
        (e) => e.name == category,
        orElse: () => PlaceCategory.other,
      ),
      externalId: externalId,
      priceLevel: priceLevel,
      publicRating: publicRating,
      personalNote: personalNote,
      personalScore: personalScore,
      lastVisitedAt: lastVisitedAt,
      layer: layer == 'personal' ? PlaceLayer.personal : PlaceLayer.public,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension PlaceNodeMapper on PlaceNode {
  PlacesTableCompanion toCompanion() {
    return PlacesTableCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      address: Value(address),
      city: Value(city),
      countryCode: Value(countryCode),
      category: Value(category.name),
      externalId: Value(externalId),
      priceLevel: Value(priceLevel),
      publicRating: Value(publicRating),
      personalNote: Value(personalNote),
      personalScore: Value(personalScore),
      lastVisitedAt: Value(lastVisitedAt),
      layer: Value(layer.name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension SemanticDescriptorMapper on SemanticDescriptorsTableData {
  SemanticDescriptor toDomain() {
    return SemanticDescriptor(
      id: id,
      placeNodeId: placeNodeId,
      descriptor: descriptor,
      source: DescriptorSource.values.firstWhere(
        (e) => e.name == source,
        orElse: () => DescriptorSource.aiGenerated,
      ),
      weight: weight,
      embeddingJson: embeddingJson,
      createdAt: createdAt,
    );
  }
}

extension SemanticDescriptorEntityMapper on SemanticDescriptor {
  SemanticDescriptorsTableCompanion toCompanion() {
    return SemanticDescriptorsTableCompanion(
      id: Value(id),
      placeNodeId: Value(placeNodeId),
      descriptor: Value(descriptor),
      source: Value(source.name),
      weight: Value(weight),
      embeddingJson: Value(embeddingJson),
      createdAt: Value(createdAt),
    );
  }
}
