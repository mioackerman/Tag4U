import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/local/drift/tables/persons_table.dart';
import 'package:tag4u/data/local/drift/tables/preference_tags_table.dart';

part 'person_dao.g.dart';

@DriftAccessor(tables: [PersonsTable, PreferenceTagsTable])
class PersonDao extends DatabaseAccessor<AppDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  // --- Persons ---

  Future<List<PersonsTableData>> getAllPersons() => select(personsTable).get();

  Future<List<PersonsTableData>> getPersonsByUserId(String userId) =>
      (select(personsTable)..where((t) => t.userId.equals(userId))).get();

  Future<PersonsTableData?> getPersonById(String id) =>
      (select(personsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertPerson(PersonsTableCompanion companion) =>
      into(personsTable).insertOnConflictUpdate(companion);

  Future<int> deletePerson(String id) =>
      (delete(personsTable)..where((t) => t.id.equals(id))).go();

  // --- Preference Tags ---

  Future<List<PreferenceTagsTableData>> getTagsForPerson(String personNodeId) =>
      (select(preferenceTagsTable)
            ..where((t) => t.personNodeId.equals(personNodeId)))
          .get();

  Future<void> upsertTag(PreferenceTagsTableCompanion companion) =>
      into(preferenceTagsTable).insertOnConflictUpdate(companion);

  Future<int> deleteTag(String tagId) =>
      (delete(preferenceTagsTable)..where((t) => t.id.equals(tagId))).go();

  Future<void> adjustTagWeight(String tagId, double delta) async {
    await customUpdate(
      '''
      UPDATE preference_tags
      SET weight = MAX(0.0, MIN(1.0, weight + ?)),
          updated_at = ?
      WHERE id = ?
      ''',
      variables: [
        Variable.withReal(delta),
        Variable.withDateTime(DateTime.now()),
        Variable.withString(tagId),
      ],
      updates: {preferenceTagsTable},
    );
  }
}
