import 'package:drift/drift.dart';

/// Drift table for [PlaceNode].
class PlacesTable extends Table {
  @override
  String get tableName => 'places';

  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get countryCode => text().nullable()();

  /// Stored as string name of [PlaceCategory] enum.
  TextColumn get category => text().withDefault(const Constant('other'))();

  TextColumn get externalId => text().nullable()();
  IntColumn get priceLevel => integer().nullable()();
  RealColumn get publicRating => real().nullable()();
  TextColumn get personalNote => text().nullable()();
  RealColumn get personalScore => real().nullable()();
  DateTimeColumn get lastVisitedAt => dateTime().nullable()();

  /// 'public' or 'personal'
  TextColumn get layer => text().withDefault(const Constant('public'))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
