/// Application-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'Tag4U';
  static const String appVersion = '1.0.0';

  // Drift database
  static const String dbFileName = 'tag4u.db';
  static const int dbSchemaVersion = 1;

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
  static const double defaultEdgeWeightThreshold = 0.3;
  static const int maxCandidatePlaces = 50;
  static const int defaultRecommendationCount = 10;

  // Privacy
  static const String encryptionAad = 'tag4u-preference-card-v1';
}
