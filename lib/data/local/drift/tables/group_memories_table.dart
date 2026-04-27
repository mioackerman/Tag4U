import 'package:drift/drift.dart';

/// Drift table for [GroupMemory].
class GroupMemoriesTable extends Table {
  @override
  String get tableName => 'group_memories';

  TextColumn get id => text()();
  TextColumn get name => text()();

  /// JSON-encoded List<String> of plan IDs.
  TextColumn get pastPlanIdsJson => text().withDefault(const Constant('[]'))();

  /// JSON-encoded List<String> of visited place IDs.
  TextColumn get visitedPlaceIdsJson => text().withDefault(const Constant('[]'))();

  /// JSON-encoded shared preference map.
  TextColumn get sharedPreferencesJson => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Junction table: GroupMemory ↔ PersonNode (many-to-many).
class GroupMembersTable extends Table {
  @override
  String get tableName => 'group_members';

  TextColumn get groupId => text()();
  TextColumn get personNodeId => text()();

  @override
  Set<Column> get primaryKey => {groupId, personNodeId};
}
