import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/tables/agent_tasks_table.dart';

/// Drift table for [RecommendationPlan].
class RecommendationPlansTable extends Table {
  @override
  String get tableName => 'recommendation_plans';

  TextColumn get id => text()();
  TextColumn get agentTaskId =>
      text().references(AgentTasksTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get groupMemoryId => text().nullable()();
  TextColumn get title => text()();

  /// JSON-encoded List<RecommendationItem>.
  TextColumn get itemsJson => text().withDefault(const Constant('[]'))();

  TextColumn get itineraryNarrative => text().nullable()();
  RealColumn get overallScore => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
