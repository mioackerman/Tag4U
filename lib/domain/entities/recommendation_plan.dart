import 'package:equatable/equatable.dart';

/// A single ranked recommendation item within a [RecommendationPlan].
class RecommendationItem extends Equatable {
  final String placeNodeId;
  final String placeName;
  final double score;

  /// Human-readable rationale for this recommendation.
  final String? rationale;

  /// Index in the ranked list (0 = best match).
  final int rank;

  const RecommendationItem({
    required this.placeNodeId,
    required this.placeName,
    required this.score,
    this.rationale,
    required this.rank,
  });

  @override
  List<Object?> get props => [placeNodeId, placeName, score, rationale, rank];
}

/// A complete recommendation plan produced by an agent.
///
/// A plan may optionally include an itinerary narrative synthesised by LLM.
class RecommendationPlan extends Equatable {
  final String id;

  /// The [AgentTask] that produced this plan.
  final String agentTaskId;

  /// Optional group context.
  final String? groupMemoryId;

  final String title;
  final List<RecommendationItem> items;

  /// LLM-generated itinerary text (markdown).
  final String? itineraryNarrative;

  final double? overallScore;

  final DateTime createdAt;

  const RecommendationPlan({
    required this.id,
    required this.agentTaskId,
    this.groupMemoryId,
    required this.title,
    this.items = const [],
    this.itineraryNarrative,
    this.overallScore,
    required this.createdAt,
  });

  RecommendationPlan copyWith({
    String? id,
    String? agentTaskId,
    String? groupMemoryId,
    String? title,
    List<RecommendationItem>? items,
    String? itineraryNarrative,
    double? overallScore,
    DateTime? createdAt,
  }) {
    return RecommendationPlan(
      id: id ?? this.id,
      agentTaskId: agentTaskId ?? this.agentTaskId,
      groupMemoryId: groupMemoryId ?? this.groupMemoryId,
      title: title ?? this.title,
      items: items ?? this.items,
      itineraryNarrative: itineraryNarrative ?? this.itineraryNarrative,
      overallScore: overallScore ?? this.overallScore,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id, agentTaskId, groupMemoryId, title, items,
        itineraryNarrative, overallScore, createdAt,
      ];
}
