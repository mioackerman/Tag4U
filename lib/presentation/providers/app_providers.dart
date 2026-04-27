import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/repositories/graph_repository_impl.dart';
import 'package:tag4u/data/repositories/person_repository_impl.dart';
import 'package:tag4u/data/repositories/place_repository_impl.dart';
import 'package:tag4u/data/repositories/recommendation_repository_impl.dart';
import 'package:tag4u/domain/repositories/i_graph_repository.dart';
import 'package:tag4u/domain/repositories/i_person_repository.dart';
import 'package:tag4u/domain/repositories/i_place_repository.dart';
import 'package:tag4u/domain/repositories/i_recommendation_repository.dart';
import 'package:tag4u/domain/usecases/get_recommendations_usecase.dart';
import 'package:tag4u/domain/usecases/plan_group_activity_usecase.dart';
import 'package:tag4u/domain/usecases/update_preference_usecase.dart';
import 'package:tag4u/infrastructure/agents/group_planning_agent.dart';
import 'package:tag4u/infrastructure/llm/anthropic_client.dart';
import 'package:tag4u/infrastructure/reasoning/hard_constraint_engine.dart';
import 'package:tag4u/infrastructure/reasoning/recommendation_pipeline.dart';
import 'package:tag4u/infrastructure/reasoning/soft_constraint_engine.dart';
import 'package:uuid/uuid.dart';

// ── Database ──────────────────────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ── DAOs ──────────────────────────────────────────────────────────────────────

final personDaoProvider = Provider((ref) => ref.watch(appDatabaseProvider).personDao);
final placeDaoProvider = Provider((ref) => ref.watch(appDatabaseProvider).placeDao);
final graphDaoProvider = Provider((ref) => ref.watch(appDatabaseProvider).graphDao);
final recommendationDaoProvider =
    Provider((ref) => ref.watch(appDatabaseProvider).recommendationDao);

// ── Utilities ─────────────────────────────────────────────────────────────────

final uuidProvider = Provider<Uuid>((_) => const Uuid());

// ── Repositories ──────────────────────────────────────────────────────────────

final personRepositoryProvider = Provider<IPersonRepository>((ref) {
  return PersonRepositoryImpl(
    dao: ref.watch(personDaoProvider),
    uuid: ref.watch(uuidProvider),
  );
});

final placeRepositoryProvider = Provider<IPlaceRepository>((ref) {
  return PlaceRepositoryImpl(dao: ref.watch(placeDaoProvider));
});

final graphRepositoryProvider = Provider<IGraphRepository>((ref) {
  return GraphRepositoryImpl(
    graphDao: ref.watch(graphDaoProvider),
    personDao: ref.watch(personDaoProvider),
  );
});

final recommendationRepositoryProvider = Provider<IRecommendationRepository>((ref) {
  return RecommendationRepositoryImpl(dao: ref.watch(recommendationDaoProvider));
});

// ── Infrastructure ────────────────────────────────────────────────────────────

/// Returns null when the key is missing — engine degrades gracefully.
final anthropicClientProvider = Provider<AnthropicClient?>((ref) {
  final key = dotenv.maybeGet('ANTHROPIC_API_KEY');
  if (key == null || key.isEmpty || key == 'your-api-key-here') return null;
  final client = AnthropicClient(apiKey: key);
  ref.onDispose(client.dispose);
  return client;
});

final hardConstraintEngineProvider =
    Provider((_) => const HardConstraintEngine());

final softConstraintEngineProvider = Provider((ref) {
  return SoftConstraintEngine(
    placeRepo: ref.watch(placeRepositoryProvider),
    llmClient: ref.watch(anthropicClientProvider),
  );
});

final groupPlanningAgentProvider = Provider((ref) {
  return GroupPlanningAgent(
    hardEngine: ref.watch(hardConstraintEngineProvider),
    softEngine: ref.watch(softConstraintEngineProvider),
  );
});

// ── Use Cases ─────────────────────────────────────────────────────────────────

final planGroupActivityUseCaseProvider = Provider((ref) {
  return PlanGroupActivityUseCase(
    graphRepo: ref.watch(graphRepositoryProvider),
    placeRepo: ref.watch(placeRepositoryProvider),
    recommendationRepo: ref.watch(recommendationRepositoryProvider),
    agent: ref.watch(groupPlanningAgentProvider),
  );
});

final getRecommendationsUseCaseProvider = Provider((ref) {
  return GetRecommendationsUseCase(
    repo: ref.watch(recommendationRepositoryProvider),
  );
});

final updatePreferenceUseCaseProvider = Provider((ref) {
  return UpdatePreferenceUseCase(
    personRepo: ref.watch(personRepositoryProvider),
  );
});

final recommendationPipelineProvider = Provider((ref) {
  return RecommendationPipeline(
    useCase: ref.watch(planGroupActivityUseCaseProvider),
  );
});
