import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/data/local/drift/daos/recommendation_dao.dart';
import 'package:tag4u/data/local/drift/mappers/recommendation_mapper.dart';
import 'package:tag4u/domain/entities/agent_task.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';
import 'package:tag4u/domain/repositories/i_recommendation_repository.dart';

class RecommendationRepositoryImpl implements IRecommendationRepository {
  final RecommendationDao _dao;

  const RecommendationRepositoryImpl({required RecommendationDao dao})
      : _dao = dao;

  @override
  ResultFuture<AgentTask> createTask(AgentTask task) async {
    try {
      await _dao.upsertTask(task.toCompanion());
      return Right(task);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<AgentTask?> getTaskById(String id) async {
    try {
      final row = await _dao.getTaskById(id);
      return Right(row?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<AgentTask>> getRecentTasks({int limit = 20}) async {
    try {
      final rows = await _dao.getRecentTasks(limit);
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<AgentTask> updateTaskStatus(
    String taskId,
    AgentTaskStatus status, {
    String? resultJson,
    String? errorMessage,
  }) async {
    try {
      final existing = await _dao.getTaskById(taskId);
      if (existing == null) {
        return const Left(DatabaseFailure(message: 'Task not found'));
      }
      final updated = existing.toDomain().copyWith(
            status: status,
            resultJson: resultJson,
            errorMessage: errorMessage,
            startedAt: status == AgentTaskStatus.running ? DateTime.now() : null,
            completedAt: (status == AgentTaskStatus.completed ||
                    status == AgentTaskStatus.failed)
                ? DateTime.now()
                : null,
          );
      await _dao.upsertTask(updated.toCompanion());
      return Right(updated);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<RecommendationPlan> savePlan(RecommendationPlan plan) async {
    try {
      await _dao.upsertPlan(plan.toCompanion());
      return Right(plan);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<RecommendationPlan?> getPlanById(String id) async {
    try {
      final row = await _dao.getPlanById(id);
      return Right(row?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<RecommendationPlan>> getPlansForTask(
    String agentTaskId,
  ) async {
    try {
      final rows = await _dao.getPlansForTask(agentTaskId);
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<RecommendationPlan>> getRecentPlans({
    String? groupMemoryId,
    int limit = 20,
  }) async {
    try {
      final rows = await _dao.getRecentPlans(
        groupMemoryId: groupMemoryId,
        limit: limit,
      );
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> recordFeedback({
    required String planId,
    required String placeNodeId,
    required double rating,
    String? comment,
  }) async {
    // TODO: Propagate weight updates to PersonNodes and RelationshipEdges.
    // For now, this stub logs the intent.
    //
    // Full implementation:
    // 1. Load plan → find matching item
    // 2. Identify which preference tags influenced the score
    // 3. Adjust tag weights (positive/negative reinforcement)
    // 4. Create/update Person↔Place edge with adjusted weight
    // 5. Update group shared preferences if group plan
    return const Right(null);
  }
}
