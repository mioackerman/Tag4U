import 'package:drift/drift.dart';

/// Drift table for [PersonNode].
class PersonsTable extends Table {
  @override
  String get tableName => 'persons';

  TextColumn get id => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get gender => text().nullable()();
  TextColumn get mbti => text().nullable()();
  BoolColumn get hasVehicle => boolean().withDefault(const Constant(false))();
  IntColumn get vehicleSeats => integer().nullable()();

  /// JSON-encoded List<String>.
  TextColumn get freeformTagsJson => text().withDefault(const Constant('[]'))();

  BoolColumn get isPrivate => boolean().withDefault(const Constant(true))();
  TextColumn get countryCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
