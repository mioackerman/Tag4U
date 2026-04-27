import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/tables/places_table.dart';

/// Drift table for [SemanticDescriptor] — public semantic place layer.
class SemanticDescriptorsTable extends Table {
  @override
  String get tableName => 'semantic_descriptors';

  TextColumn get id => text()();
  TextColumn get placeNodeId =>
      text().references(PlacesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get descriptor => text()();

  /// 'ai_generated' | 'user_defined' | 'feedback_derived'
  TextColumn get source => text().withDefault(const Constant('ai_generated'))();

  RealColumn get weight => real().withDefault(const Constant(1.0))();

  /// JSON-encoded float list (embedding vector).
  TextColumn get embeddingJson => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
