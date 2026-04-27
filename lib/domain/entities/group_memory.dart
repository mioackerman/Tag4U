import 'package:equatable/equatable.dart';

/// Represents a shared memory space for a group of people.
///
/// Captures collective past experiences and emergent group preferences
/// that differ from individual preferences.
class GroupMemory extends Equatable {
  final String id;
  final String name;

  /// IDs of [PersonNode]s that are members of this group.
  final List<String> memberIds;

  /// IDs of [RecommendationPlan]s generated for this group.
  final List<String> pastPlanIds;

  /// IDs of [PlaceNode]s the group has visited together.
  final List<String> visitedPlaceIds;

  /// Aggregate group-level preferences derived from collective feedback.
  /// Stored as a JSON string for flexibility.
  final String? sharedPreferencesJson;

  final DateTime createdAt;
  final DateTime updatedAt;

  const GroupMemory({
    required this.id,
    required this.name,
    this.memberIds = const [],
    this.pastPlanIds = const [],
    this.visitedPlaceIds = const [],
    this.sharedPreferencesJson,
    required this.createdAt,
    required this.updatedAt,
  });

  GroupMemory copyWith({
    String? id,
    String? name,
    List<String>? memberIds,
    List<String>? pastPlanIds,
    List<String>? visitedPlaceIds,
    String? sharedPreferencesJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupMemory(
      id: id ?? this.id,
      name: name ?? this.name,
      memberIds: memberIds ?? this.memberIds,
      pastPlanIds: pastPlanIds ?? this.pastPlanIds,
      visitedPlaceIds: visitedPlaceIds ?? this.visitedPlaceIds,
      sharedPreferencesJson: sharedPreferencesJson ?? this.sharedPreferencesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, name, memberIds, pastPlanIds, visitedPlaceIds,
        sharedPreferencesJson, createdAt, updatedAt,
      ];
}
