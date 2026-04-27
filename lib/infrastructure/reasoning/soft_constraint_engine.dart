import 'dart:math' as math;
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/domain/repositories/i_place_repository.dart';

/// Scored place for the pipeline.
class ScoredPlace {
  final PlaceNode place;
  final double score; // 0.0 – 1.0

  const ScoredPlace({required this.place, required this.score});
}

/// Soft constraint engine — semantic preference matching.
///
/// Uses keyword/embedding similarity to match:
///   - Place [SemanticDescriptor]s against group preference vector keys.
///   - Free-form activity hints against place descriptions.
///
/// The LLM / embedding integration points are clearly marked with TODO
/// so they can be wired to an actual model (OpenAI, Anthropic, on-device).
class SoftConstraintEngine {
  final IPlaceRepository _placeRepo;

  const SoftConstraintEngine({required IPlaceRepository placeRepo})
      : _placeRepo = placeRepo;

  /// Scores each candidate place against the [preferenceVector].
  ///
  /// [preferenceVector] — map of label → signed weight (-1.0 to 1.0).
  ///   Positive = group likes this trait.
  ///   Negative = group dislikes this trait.
  ///
  /// [hint] — optional free-text activity hint (e.g. "romantic dinner").
  Future<List<ScoredPlace>> score({
    required List<PlaceNode> candidates,
    required Map<String, double> preferenceVector,
    String? hint,
  }) async {
    final results = <ScoredPlace>[];

    for (final place in candidates) {
      var score = _baseScore(place);

      // Load semantic descriptors for this place
      final descriptorResult = await _placeRepo.getDescriptorsForPlace(place.id);
      final descriptors = descriptorResult.fold((_) => <SemanticDescriptor>[], (d) => d);

      // Preference vector matching
      final prefScore = _matchPreferences(descriptors, preferenceVector);
      score += prefScore * 0.5;

      // Hint matching
      if (hint != null && hint.isNotEmpty) {
        final hintScore = _matchHint(place, descriptors, hint);
        score += hintScore * 0.2;
      }

      results.add(ScoredPlace(
        place: place,
        score: score.clamp(0.0, 1.0),
      ));
    }

    return results;
  }

  /// Computes group-compatibility scores after individual scoring.
  ///
  /// Returns a map of placeId → final compatibility score.
  Future<Map<String, double>> scoreGroupCompatibility({
    required List<PlaceNode> places,
    required List<String> memberIds,
    required Map<String, double> groupPreferenceVector,
  }) async {
    final scores = <String, double>{};

    for (final place in places) {
      // TODO: For each member, run individual preference scoring and
      // compute how many members are satisfied (consensus score).
      // For now, use the already-computed group vector score as proxy.
      final descriptorResult = await _placeRepo.getDescriptorsForPlace(place.id);
      final descriptors = descriptorResult.fold((_) => <SemanticDescriptor>[], (d) => d);
      final pref = _matchPreferences(descriptors, groupPreferenceVector);
      scores[place.id] = (_baseScore(place) + pref * 0.5).clamp(0.0, 1.0);
    }

    return scores;
  }

  /// Synthesises an itinerary narrative using LLM.
  ///
  /// TODO: Wire to Anthropic / OpenAI API.
  Future<String?> synthesiseItinerary({
    required List<PlaceNode> topPlaces,
    String? activityHint,
    required int memberCount,
  }) async {
    // Stub: returns a structured placeholder until LLM is wired.
    final placeList = topPlaces.map((p) => '- ${p.name}').join('\n');
    return '''
## Suggested Itinerary
*For $memberCount people${activityHint != null ? ' · $activityHint' : ''}*

$placeList

> Full LLM-generated narrative will appear here once the AI backend is configured.
''';
  }

  // --- Private helpers ---

  double _baseScore(PlaceNode place) {
    double score = 0.3; // baseline
    if (place.publicRating != null) {
      // Normalise 0-5 rating to 0.0-0.4 contribution
      score += (place.publicRating! / 5.0) * 0.4;
    }
    if (place.personalScore != null) {
      // Personal memory: -1 to 1 → add 0 to 0.3
      score += (place.personalScore! + 1.0) / 2.0 * 0.3;
    }
    return score.clamp(0.0, 1.0);
  }

  double _matchPreferences(
    List<SemanticDescriptor> descriptors,
    Map<String, double> preferenceVector,
  ) {
    if (descriptors.isEmpty || preferenceVector.isEmpty) return 0.0;

    var total = 0.0;
    var count = 0;

    for (final descriptor in descriptors) {
      final dText = descriptor.descriptor.toLowerCase();

      for (final entry in preferenceVector.entries) {
        final prefKey = entry.key.toLowerCase();
        final prefWeight = entry.value;

        // TODO: Replace with embedding cosine similarity.
        // Current: simple substring overlap score.
        final overlap = _keywordOverlap(dText, prefKey);
        if (overlap > 0) {
          total += overlap * prefWeight * descriptor.weight;
          count++;
        }
      }
    }

    return count > 0 ? (total / count).clamp(-1.0, 1.0) : 0.0;
  }

  double _matchHint(
    PlaceNode place,
    List<SemanticDescriptor> descriptors,
    String hint,
  ) {
    final hintLower = hint.toLowerCase();
    final nameLower = place.name.toLowerCase();

    double score = 0.0;

    // Check name
    if (_keywordOverlap(nameLower, hintLower) > 0) score += 0.3;

    // Check descriptors
    for (final d in descriptors) {
      score += _keywordOverlap(d.descriptor.toLowerCase(), hintLower) * 0.1;
    }

    return score.clamp(0.0, 1.0);
  }

  /// Normalised keyword overlap (Jaccard-like on word tokens).
  double _keywordOverlap(String text, String query) {
    final textWords = text.split(RegExp(r'\W+')).toSet();
    final queryWords = query.split(RegExp(r'\W+')).toSet();
    if (queryWords.isEmpty) return 0.0;
    final intersection = textWords.intersection(queryWords);
    return intersection.length / math.max(queryWords.length.toDouble(), 1.0);
  }
}
