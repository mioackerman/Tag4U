import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/local/drift/tables/agent_tasks_table.dart';
import 'package:tag4u/data/local/drift/tables/recommendation_plans_table.dart';

part 'recommendation_dao.g.dart';

@DriftAccessor(tables: [AgentTasksTable, RecommendationPlansTable])
class RecommendationDao extends DatabaseAccessor<AppDatabase>
    with _$RecommendationDaoMixin {
  RecommendationDao(super.db);

  // --- Agent Tasks ---

  Future<void> upsertTask(AgentTasksTableCompanion companion) =>
      into(agentTasksTable).insertOnConflictUpdate(companion);

  Future<AgentTasksTableData?> getTaskById(String id) =>
      (select(agentTasksTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<AgentTasksTableData>> getRecentTasks(int limit) =>
      (select(agentTasksTable)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(limit))
          .get();

  // --- Recommendation Plans ---

  Future<void> upsertPlan(RecommendationPlansTableCompanion companion) =>
      into(recommendationPlansTable).insertOnConflictUpdate(companion);

  Future<RecommendationPlansTableData?> getPlanById(String id) =>
      (select(recommendationPlansTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<RecommendationPlansTableData>> getPlansForTask(String agentTaskId) =>
      (select(recommendationPlansTable)
            ..where((t) => t.agentTaskId.equals(agentTaskId)))
          .get();

  Future<List<RecommendationPlansTableData>> getRecentPlans({
    String? groupMemoryId,
    required int limit,
  }) {
    final query = select(recommendationPlansTable)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);
    if (groupMemoryId != null) {
      query.where((t) => t.groupMemoryId.equals(groupMemoryId));
    }
    return query.get();
  }
}
