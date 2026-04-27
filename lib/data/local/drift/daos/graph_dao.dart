import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/local/drift/tables/group_memories_table.dart';
import 'package:tag4u/data/local/drift/tables/relationship_edges_table.dart';

part 'graph_dao.g.dart';

@DriftAccessor(tables: [RelationshipEdgesTable, GroupMemoriesTable, GroupMembersTable])
class GraphDao extends DatabaseAccessor<AppDatabase> with _$GraphDaoMixin {
  GraphDao(super.db);

  // --- Relationship Edges ---

  Future<List<RelationshipEdgesTableData>> getEdgesFrom(
    String fromNodeId, {
    String? toNodeType,
    String? label,
  }) {
    var query = select(relationshipEdgesTable)
      ..where((t) => t.fromNodeId.equals(fromNodeId));
    if (toNodeType != null) {
      query = query..where((t) => t.toNodeType.equals(toNodeType));
    }
    if (label != null) {
      query = query..where((t) => t.label.equals(label));
    }
    return query.get();
  }

  Future<List<RelationshipEdgesTableData>> getEdgesTo(
    String toNodeId, {
    String? fromNodeType,
    String? label,
  }) {
    var query = select(relationshipEdgesTable)
      ..where((t) => t.toNodeId.equals(toNodeId));
    if (fromNodeType != null) {
      query = query..where((t) => t.fromNodeType.equals(fromNodeType));
    }
    if (label != null) {
      query = query..where((t) => t.label.equals(label));
    }
    return query.get();
  }

  Future<void> upsertEdge(RelationshipEdgesTableCompanion companion) =>
      into(relationshipEdgesTable).insertOnConflictUpdate(companion);

  Future<int> deleteEdge(String id) =>
      (delete(relationshipEdgesTable)..where((t) => t.id.equals(id))).go();

  Future<void> adjustEdgeWeight(String edgeId, double delta) async {
    await customUpdate(
      '''
      UPDATE relationship_edges
      SET weight = MAX(0.0, MIN(1.0, weight + ?)),
          updated_at = ?
      WHERE id = ?
      ''',
      variables: [
        Variable.withReal(delta),
        Variable.withDateTime(DateTime.now()),
        Variable.withString(edgeId),
      ],
      updates: {relationshipEdgesTable},
    );
  }

  // --- Group Memories ---

  Future<List<GroupMemoriesTableData>> getAllGroupMemories() =>
      select(groupMemoriesTable).get();

  Future<GroupMemoriesTableData?> getGroupMemoryById(String id) =>
      (select(groupMemoriesTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertGroupMemory(GroupMemoriesTableCompanion companion) =>
      into(groupMemoriesTable).insertOnConflictUpdate(companion);

  Future<int> deleteGroupMemory(String id) =>
      (delete(groupMemoriesTable)..where((t) => t.id.equals(id))).go();

  // --- Group Members (junction) ---

  Future<List<GroupMembersTableData>> getMembersOfGroup(String groupId) =>
      (select(groupMembersTable)..where((t) => t.groupId.equals(groupId))).get();

  Future<void> addGroupMember(String groupId, String personNodeId) =>
      into(groupMembersTable).insertOnConflictUpdate(
        GroupMembersTableCompanion.insert(
          groupId: groupId,
          personNodeId: personNodeId,
        ),
      );

  Future<int> removeGroupMember(String groupId, String personNodeId) =>
      (delete(groupMembersTable)
            ..where((t) =>
                t.groupId.equals(groupId) & t.personNodeId.equals(personNodeId)))
          .go();
}
