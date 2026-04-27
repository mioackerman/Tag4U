import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/domain/usecases/plan_group_activity_usecase.dart';

/// Thin façade over the agent-based planning stack.
///
/// Exposes a single [execute] method that drives the full pipeline:
///
///   retrieve candidates
///       ↓
///   apply hard filters
///       ↓
///   semantic preference scoring
///       ↓
///   group compatibility scoring
///       ↓
///   generate ranked recommendations
///       ↓
///   optional itinerary synthesis
///
/// The pipeline is modular — each stage lives in its own class and
/// can be swapped or extended independently.
class RecommendationPipeline {
  final PlanGroupActivityUseCase _useCase;

  const RecommendationPipeline({required PlanGroupActivityUseCase useCase})
      : _useCase = useCase;

  ResultFuture<RecommendationPlan> execute(PlanGroupActivityParams params) {
    return _useCase.call(params);
  }
}
