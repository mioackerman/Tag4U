import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tag4u/core/constants/app_constants.dart';
import 'package:tag4u/data/local/drift/daos/graph_dao.dart';
import 'package:tag4u/data/local/drift/daos/person_dao.dart';
import 'package:tag4u/data/local/drift/daos/place_dao.dart';
import 'package:tag4u/data/local/drift/daos/recommendation_dao.dart';
import 'package:tag4u/data/local/drift/tables/agent_tasks_table.dart';
import 'package:tag4u/data/local/drift/tables/group_memories_table.dart';
import 'package:tag4u/data/local/drift/tables/persons_table.dart';
import 'package:tag4u/data/local/drift/tables/places_table.dart';
import 'package:tag4u/data/local/drift/tables/preference_tags_table.dart';
import 'package:tag4u/data/local/drift/tables/recommendation_plans_table.dart';
import 'package:tag4u/data/local/drift/tables/relationship_edges_table.dart';
import 'package:tag4u/data/local/drift/tables/semantic_descriptors_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    PersonsTable,
    PlacesTable,
    PreferenceTagsTable,
    SemanticDescriptorsTable,
    RelationshipEdgesTable,
    GroupMemoriesTable,
    GroupMembersTable,
    AgentTasksTable,
    RecommendationPlansTable,
  ],
  daos: [
    PersonDao,
    PlaceDao,
    GraphDao,
    RecommendationDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.dbSchemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await _createIndexes();
      },
      onUpgrade: (m, from, to) async {
        // Future migrations go here.
      },
    );
  }

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_edges_from ON relationship_edges(from_node_id, label)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_edges_to ON relationship_edges(to_node_id, label)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_tags_person ON preference_tags(person_node_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_descriptors_place ON semantic_descriptors(place_node_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_plans_task ON recommendation_plans(agent_task_id)',
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: AppConstants.dbFileName);
  }
}
