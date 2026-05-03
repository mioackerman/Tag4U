import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/tables/persons_table.dart';

/// Drift table for [PreferenceTag].
class PreferenceTagsTable extends Table {
  @override
  String get tableName => 'preference_tags';

  TextColumn get id => text()();
  TextColumn get personNodeId =>
      text().references(PersonsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get label => text()();

  /// 'positive' | 'negative' | 'neutral'
  TextColumn get sentiment => text().withDefault(const Constant('neutral'))();

  RealColumn get weight => real().withDefault(const Constant(0.5))();
  TextColumn get context => text().nullable()();

  /// 'user_explicit' | 'inferred' | 'feedback_loop' | 'imported'
  TextColumn get source => text().withDefault(const Constant('user_explicit'))();

  /// Whether this tag is visible when sharing a preference card.
  BoolColumn get isPublic => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
