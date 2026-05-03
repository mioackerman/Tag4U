/// Application-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'Tag4U';
  static const String appVersion = '1.0.0';

  // Drift database
  static const String dbFileName = 'tag4u.db';
  static const int dbSchemaVersion = 2;

  // Graph edge labels (well-known, but open to extension)
  static const String edgeDislikes = 'dislikes';
  static const String edgeLikes = 'likes';
  static const String edgeGoodFor = 'good_for';
  static const String edgeAvoid = 'avoid';
  static const String edgeVisited = 'visited';
  static const String edgeWantsToVisit = 'wants_to_visit';
  static const String edgeKnows = 'knows';

  // Recommendation pipeline
  static const double defaultHardDistanceKm = 30.0;

  /// Extra scoring bonus applied to personal-layer places (user-created) vs.
  /// public/imported places during soft constraint scoring.
  ///
  /// Variable location : lib/core/constants/app_constants.dart
  ///                     → AppConstants.personalPlaceWeightBonus
  /// Applied in        : lib/infrastructure/reasoning/soft_constraint_engine.dart
  ///                     → SoftConstraintEngine._baseScore()
  static const double personalPlaceWeightBonus = 0.15;
  static const double defaultEdgeWeightThreshold = 0.3;
  static const int maxCandidatePlaces = 50;
  static const int defaultRecommendationCount = 10;

  // Privacy
  static const String encryptionAad = 'tag4u-preference-card-v1';
}
