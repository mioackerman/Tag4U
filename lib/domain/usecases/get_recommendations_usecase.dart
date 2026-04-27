import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/domain/repositories/i_recommendation_repository.dart';
import 'package:tag4u/domain/usecases/base_usecase.dart';

class GetRecommendationsParams {
  final String? groupMemoryId;
  final int limit;

  const GetRecommendationsParams({this.groupMemoryId, this.limit = 20});
}

/// Returns previously generated plans, most recent first.
class GetRecommendationsUseCase
    extends UseCase<List<RecommendationPlan>, GetRecommendationsParams> {
  final IRecommendationRepository _repo;

  const GetRecommendationsUseCase({required IRecommendationRepository repo})
      : _repo = repo;

  @override
  ResultFuture<List<RecommendationPlan>> call(GetRecommendationsParams params) {
    return _repo.getRecentPlans(
      groupMemoryId: params.groupMemoryId,
      limit: params.limit,
    );
  }
}
