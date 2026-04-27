import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/domain/usecases/get_recommendations_usecase.dart';
import 'package:tag4u/domain/usecases/plan_group_activity_usecase.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';

// ── Recent plans ──────────────────────────────────────────────────────────────

final recentPlansProvider =
    AsyncNotifierProvider<RecentPlansNotifier, List<RecommendationPlan>>(
  RecentPlansNotifier.new,
);

class RecentPlansNotifier extends AsyncNotifier<List<RecommendationPlan>> {
  @override
  Future<List<RecommendationPlan>> build() async {
    final result = await ref.watch(getRecommendationsUseCaseProvider).call(
          const GetRecommendationsParams(limit: 20),
        );
    return result.fold((f) => throw Exception(f.message), (v) => v);
  }

  Future<void> refresh() => ref.refresh(recentPlansProvider.future);
}

// ── Active planning session ───────────────────────────────────────────────────

/// Notifier that drives the full planning pipeline.
///
/// Usage:
///   ref.read(planningSessionProvider.notifier).start(params);
final planningSessionProvider = AsyncNotifierProvider<PlanningSessionNotifier,
    RecommendationPlan?>(PlanningSessionNotifier.new);

class PlanningSessionNotifier extends AsyncNotifier<RecommendationPlan?> {
  @override
  Future<RecommendationPlan?> build() async => null;

  Future<void> start(PlanGroupActivityParams params) async {
    state = const AsyncLoading();
    final result =
        await ref.read(planGroupActivityUseCaseProvider).call(params);
    state = result.fold(
      (failure) => AsyncError(Exception(failure.message), StackTrace.current),
      AsyncData.new,
    );
    // Refresh history
    ref.invalidate(recentPlansProvider);
  }

  void reset() => state = const AsyncData(null);
}
