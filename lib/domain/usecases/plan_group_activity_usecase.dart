import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/agent_task.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/domain/repositories/i_graph_repository.dart';
import 'package:tag4u/domain/repositories/i_place_repository.dart';
import 'package:tag4u/domain/repositories/i_recommendation_repository.dart';
import 'package:tag4u/domain/usecases/base_usecase.dart';
import 'package:tag4u/infrastructure/agents/base_agent.dart';
import 'package:tag4u/infrastructure/agents/group_planning_agent.dart';

class PlanGroupActivityParams {
  final List<String> memberIds;
  final String? groupMemoryId;
  final double lat;
  final double lng;
  final double radiusKm;
  final double? maxBudgetPerPerson;
  final String? activityHint; // e.g. "dinner + something fun after"
  final bool synthesiseItinerary;

  const PlanGroupActivityParams({
    required this.memberIds,
    this.groupMemoryId,
    required this.lat,
    required this.lng,
    this.radiusKm = 10.0,
    this.maxBudgetPerPerson,
    this.activityHint,
    this.synthesiseItinerary = false,
  });
}

/// Orchestrates the full group planning pipeline:
///   1. Builds planning context (members + group memory)
///   2. Dispatches to [GroupPlanningAgent]
///   3. Persists the resulting [RecommendationPlan]
class PlanGroupActivityUseCase
    extends UseCase<RecommendationPlan, PlanGroupActivityParams> {
  final IGraphRepository _graphRepo;
  final IPlaceRepository _placeRepo;
  final IRecommendationRepository _recommendationRepo;
  final GroupPlanningAgent _agent;

  const PlanGroupActivityUseCase({
    required IGraphRepository graphRepo,
    required IPlaceRepository placeRepo,
    required IRecommendationRepository recommendationRepo,
    required GroupPlanningAgent agent,
  })  : _graphRepo = graphRepo,
        _placeRepo = placeRepo,
        _recommendationRepo = recommendationRepo,
        _agent = agent;

  @override
  ResultFuture<RecommendationPlan> call(PlanGroupActivityParams params) async {
    // 1. Build group preference vector
    final vectorResult = await _graphRepo.computeGroupPreferenceVector(
      params.memberIds,
      params.groupMemoryId,
    );
    if (vectorResult.isLeft()) {
      return Left(vectorResult.fold((f) => f, (_) => const UnexpectedFailure(message: '')));
    }
    final preferenceVector = vectorResult.getOrElse(() => {});

    // 2. Retrieve nearby candidate places
    final candidatesResult = await _placeRepo.searchNearby(
      lat: params.lat,
      lng: params.lng,
      radiusKm: params.radiusKm,
    );
    if (candidatesResult.isLeft()) {
      return Left(candidatesResult.fold((f) => f, (_) => const UnexpectedFailure(message: '')));
    }
    final candidates = candidatesResult.getOrElse(() => []);

    // 3. Build agent context and create task record
    final context = AgentContext(
      memberIds: params.memberIds,
      groupMemoryId: params.groupMemoryId,
      groupPreferenceVector: preferenceVector,
      candidatePlaces: candidates,
      lat: params.lat,
      lng: params.lng,
      radiusKm: params.radiusKm,
      maxBudgetPerPerson: params.maxBudgetPerPerson,
      activityHint: params.activityHint,
      synthesiseItinerary: params.synthesiseItinerary,
    );

    final taskResult = await _recommendationRepo.createTask(
      AgentTask(
        id: context.taskId,
        agentType: GroupPlanningAgent.kAgentType,
        contextJson: context.toJson(),
        createdAt: DateTime.now(),
      ),
    );
    if (taskResult.isLeft()) {
      return Left(taskResult.fold((f) => f, (_) => const UnexpectedFailure(message: '')));
    }

    // 4. Run the agent
    final planResult = await _agent.run(context);
    if (planResult.isLeft()) {
      await _recommendationRepo.updateTaskStatus(
        context.taskId,
        AgentTaskStatus.failed,
        errorMessage: planResult.fold((f) => f.message, (_) => null),
      );
      return planResult;
    }

    final plan = planResult.getOrElse(() => throw StateError('unreachable'));

    // 5. Persist plan and mark task complete
    await _recommendationRepo.updateTaskStatus(
      context.taskId,
      AgentTaskStatus.completed,
      resultJson: '{"planId":"${plan.id}"}',
    );
    return _recommendationRepo.savePlan(plan);
  }
}
