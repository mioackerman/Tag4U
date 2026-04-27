import 'package:equatable/equatable.dart';

enum NodeType { person, place, preferenceTag, semanticDescriptor, group }

/// A directed, weighted edge in the preference graph.
///
/// Supports any pairing of node types. Well-known [label]s are defined
/// in [AppConstants], but users may add arbitrary labels.
///
/// Examples:
///   fromNodeId: "friend_alice"   fromType: person
///   toNodeId:   "cafe_xyz"       toType: place
///   label:      "good_first_date"
///   weight:     0.8
///
///   fromNodeId: "friend_alice"   fromType: person
///   toNodeId:   "loud_bars"      toType: preferenceTag
///   label:      "dislikes_noise"
///   weight:     0.9
class RelationshipEdge extends Equatable {
  final String id;
  final String fromNodeId;
  final NodeType fromNodeType;
  final String toNodeId;
  final NodeType toNodeType;

  /// Semantic label for this edge (free-form, lowercased snake_case preferred).
  final String label;

  /// Edge weight (0.0 – 1.0). Higher = stronger relationship.
  final double weight;

  /// Arbitrary JSON metadata for future extensibility.
  final String? metadataJson;

  final DateTime createdAt;
  final DateTime updatedAt;

  const RelationshipEdge({
    required this.id,
    required this.fromNodeId,
    required this.fromNodeType,
    required this.toNodeId,
    required this.toNodeType,
    required this.label,
    this.weight = 0.5,
    this.metadataJson,
    required this.createdAt,
    required this.updatedAt,
  });

  RelationshipEdge copyWith({
    String? id,
    String? fromNodeId,
    NodeType? fromNodeType,
    String? toNodeId,
    NodeType? toNodeType,
    String? label,
    double? weight,
    String? metadataJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RelationshipEdge(
      id: id ?? this.id,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      fromNodeType: fromNodeType ?? this.fromNodeType,
      toNodeId: toNodeId ?? this.toNodeId,
      toNodeType: toNodeType ?? this.toNodeType,
      label: label ?? this.label,
      weight: weight ?? this.weight,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, fromNodeId, fromNodeType, toNodeId, toNodeType,
        label, weight, metadataJson, createdAt, updatedAt,
      ];
}
