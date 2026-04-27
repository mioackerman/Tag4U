import 'dart:convert';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:uuid/uuid.dart';

/// Context object passed to every agent.
///
/// Carries everything the agent needs to produce a [RecommendationPlan]:
/// member preferences, candidate places, hard constraints, and hints.
class AgentContext {
  final String taskId;
  final List<String> memberIds;
  final String? groupMemoryId;
  final Map<String, double> groupPreferenceVector;
  final List<PlaceNode> candidatePlaces;
  final double lat;
  final double lng;
  final double radiusKm;
  final double? maxBudgetPerPerson;
  final String? activityHint;
  final bool synthesiseItinerary;

  AgentContext({
    String? taskId,
    required this.memberIds,
    this.groupMemoryId,
    required this.groupPreferenceVector,
    required this.candidatePlaces,
    required this.lat,
    required this.lng,
    required this.radiusKm,
    this.maxBudgetPerPerson,
    this.activityHint,
    this.synthesiseItinerary = false,
  }) : taskId = taskId ?? const Uuid().v4();

  String toJson() => jsonEncode({
        'taskId': taskId,
        'memberIds': memberIds,
        'groupMemoryId': groupMemoryId,
        'groupPreferenceVector': groupPreferenceVector,
        'candidatePlaceIds': candidatePlaces.map((p) => p.id).toList(),
        'lat': lat,
        'lng': lng,
        'radiusKm': radiusKm,
        'maxBudgetPerPerson': maxBudgetPerPerson,
        'activityHint': activityHint,
        'synthesiseItinerary': synthesiseItinerary,
      });
}

/// Base interface for all agents in the preference graph OS.
///
/// Agents are pluggable and share the same [AgentContext] + graph access.
/// New agents can be added without modifying the pipeline or use-cases.
abstract class BaseAgent {
  const BaseAgent();

  /// Unique string identifier for this agent type.
  String get agentType;

  /// Analyse context and prepare any pre-processing needed.
  Future<void> analyze(AgentContext context);

  /// Build a plan structure from the context (without LLM calls).
  Future<AgentContext> plan(AgentContext context);

  /// Score and rank candidate places.
  Future<List<PlaceNode>> rank(AgentContext context);

  /// Execute the full pipeline and return a [RecommendationPlan].
  ResultFuture<RecommendationPlan> run(AgentContext context);
}
