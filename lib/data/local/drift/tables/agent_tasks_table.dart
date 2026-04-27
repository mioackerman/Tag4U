import 'package:drift/drift.dart';

/// Drift table for [AgentTask].
class AgentTasksTable extends Table {
  @override
  String get tableName => 'agent_tasks';

  TextColumn get id => text()();
  TextColumn get agentType => text()();

  /// String name of [AgentTaskStatus] enum.
  TextColumn get status => text().withDefault(const Constant('pending'))();

  TextColumn get contextJson => text()();
  TextColumn get resultJson => text().nullable()();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
