import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/infrastructure/agents/base_agent.dart';
import 'package:tag4u/infrastructure/reasoning/hard_constraint_engine.dart';
import 'package:tag4u/infrastructure/reasoning/recommendation_pipeline.dart';
import 'package:tag4u/infrastructure/reasoning/soft_constraint_engine.dart';
import 'package:uuid/uuid.dart';

/// The primary agent for multi-person group activity planning.
///
/// Pipeline:
///   1. analyze  — validate context, surface constraint conflicts
///   2. plan     — structure the constraint & preference data
///   3. rank     — hard-filter + soft-score candidates
///   4. run      — orchestrate all stages, return [RecommendationPlan]
class GroupPlanningAgent extends BaseAgent {
  static const String agentType = 'group_planning';

  final HardConstraintEngine _hardEngine;
  final SoftConstraintEngine _softEngine;
  final Uuid _uuid;

  const GroupPlanningAgent({
    required HardConstraintEngine hardEngine,
    required SoftConstraintEngine softEngine,
    Uuid? uuid,
  })  : _hardEngine = hardEngine,
        _softEngine = softEngine,
        _uuid = uuid ?? const Uuid();

  @override
  String get agentType => GroupPlanningAgent.agentType;

  @override
  Future<void> analyze(AgentContext context) async {
    // Validate: must have at least one member
    assert(context.memberIds.isNotEmpty, 'GroupPlanningAgent requires at least one member');
    // Optionally surface conflict warnings (e.g. budget vs. area density)
  }

  @override
  Future<AgentContext> plan(AgentContext context) async {
    // For now, return context unchanged.
    // Future: extract structured constraints, resolve conflicts.
    return context;
  }

  @override
  Future<List<PlaceNode>> rank(AgentContext context) async {
    // Stage 1: Hard filters (distance, budget, availability)
    var filtered = _hardEngine.filter(
      candidates: context.candidatePlaces,
      lat: context.lat,
      lng: context.lng,
      radiusKm: context.radiusKm,
      maxBudgetLevel: context.maxBudgetPerPerson != null
          ? _budgetToLevel(context.maxBudgetPerPerson!)
          : null,
    );

    // Stage 2: Soft scoring (semantic preference matching)
    final scored = await _softEngine.score(
      candidates: filtered,
      preferenceVector: context.groupPreferenceVector,
      hint: context.activityHint,
    );

    // Return top-N sorted by score descending
    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.map((s) => s.place).toList();
  }

  @override
  ResultFuture<RecommendationPlan> run(AgentContext context) async {
    try {
      await analyze(context);
      final plannedContext = await plan(context);
      final rankedPlaces = await rank(plannedContext);

      // Stage 3: Group compatibility scoring
      final compatScores = await _softEngine.scoreGroupCompatibility(
        places: rankedPlaces,
        memberIds: context.memberIds,
        groupPreferenceVector: context.groupPreferenceVector,
      );

      // Stage 4: Build RecommendationItems
      final items = <RecommendationItem>[];
      for (var i = 0; i < rankedPlaces.length; i++) {
        final place = rankedPlaces[i];
        items.add(RecommendationItem(
          placeNodeId: place.id,
          placeName: place.name,
          score: compatScores[place.id] ?? 0.5,
          rationale: _buildRationale(place, context),
          rank: i,
        ));
      }

      // Stage 5: Optional itinerary synthesis (LLM call)
      String? narrative;
      if (context.synthesiseItinerary && items.isNotEmpty) {
        narrative = await _softEngine.synthesiseItinerary(
          topPlaces: rankedPlaces.take(5).toList(),
          activityHint: context.activityHint,
          memberCount: context.memberIds.length,
        );
      }

      final plan = RecommendationPlan(
        id: _uuid.v4(),
        agentTaskId: context.taskId,
        groupMemoryId: context.groupMemoryId,
        title: _buildTitle(context),
        items: items,
        itineraryNarrative: narrative,
        overallScore: items.isNotEmpty
            ? items.map((i) => i.score).reduce((a, b) => a + b) / items.length
            : null,
        createdAt: DateTime.now(),
      );

      return Right(plan);
    } catch (e) {
      return Left(AgentFailure(message: e.toString()));
    }
  }

  String _buildTitle(AgentContext context) {
    final groupSize = context.memberIds.length;
    final hint = context.activityHint;
    if (hint != null && hint.isNotEmpty) {
      return 'Plan for $groupSize people — $hint';
    }
    return 'Group plan for $groupSize people';
  }

  String _buildRationale(PlaceNode place, AgentContext context) {
    final parts = <String>[];
    if (place.publicRating != null) {
      parts.add('Rated ${place.publicRating!.toStringAsFixed(1)}');
    }
    if (place.priceLevel != null) {
      parts.add('Price level ${place.priceLevel}');
    }
    return parts.isNotEmpty ? parts.join(' · ') : 'Matches group preferences';
  }

  int _budgetToLevel(double budget) {
    if (budget < 15) return 1;
    if (budget < 40) return 2;
    if (budget < 100) return 3;
    return 4;
  }
}
