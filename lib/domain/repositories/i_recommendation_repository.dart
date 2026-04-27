import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/agent_task.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';

abstract class IRecommendationRepository {
  // --- Agent Tasks ---

  ResultFuture<AgentTask> createTask(AgentTask task);

  ResultFuture<AgentTask?> getTaskById(String id);

  ResultFuture<List<AgentTask>> getRecentTasks({int limit = 20});

  ResultFuture<AgentTask> updateTaskStatus(
    String taskId,
    AgentTaskStatus status, {
    String? resultJson,
    String? errorMessage,
  });

  // --- Recommendation Plans ---

  ResultFuture<RecommendationPlan> savePlan(RecommendationPlan plan);

  ResultFuture<RecommendationPlan?> getPlanById(String id);

  ResultFuture<List<RecommendationPlan>> getPlansForTask(String agentTaskId);

  ResultFuture<List<RecommendationPlan>> getRecentPlans({
    String? groupMemoryId,
    int limit = 20,
  });

  // --- Feedback loop ---

  /// Records user feedback on a [RecommendationItem] and propagates weight
  /// updates back into the preference graph.
  ResultFuture<void> recordFeedback({
    required String planId,
    required String placeNodeId,
    required double rating, // -1.0 to 1.0
    String? comment,
  });
}
