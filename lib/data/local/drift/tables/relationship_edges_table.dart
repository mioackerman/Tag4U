import 'package:drift/drift.dart';

/// Drift table for [RelationshipEdge] — the core of the preference graph.
class RelationshipEdgesTable extends Table {
  @override
  String get tableName => 'relationship_edges';

  TextColumn get id => text()();
  TextColumn get fromNodeId => text()();

  /// String name of [NodeType] enum.
  TextColumn get fromNodeType => text()();

  TextColumn get toNodeId => text()();
  TextColumn get toNodeType => text()();
  TextColumn get label => text()();
  RealColumn get weight => real().withDefault(const Constant(0.5))();
  TextColumn get metadataJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  // Index declarations via @TableIndex are added after build_runner runs.
  // Manually index (fromNodeId, label) and (toNodeId, label) for graph traversal.
}
