import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';

// ── Weight constants ──────────────────────────────────────────────────────────
// Tune here; these variables are the single source of truth for match scoring.

/// Score added when a place's category matches a selected activity type.
const double kCategoryMatchWeight = 2.0;

/// Multiplier applied to descriptor.weight for user-defined tags vs AI tags.
const double kUserDefinedTagMultiplier = 1.5;

/// Score added per positive person-tag that matches a place descriptor.
const double kPersonPositiveTagWeight = 1.2;

/// Score subtracted per negative person-tag that matches a place descriptor.
const double kPersonNegativeTagWeight = 1.5;

/// Fraction of personalScore (-1..1) added to the total match score.
const double kPersonalScoreBonus = 0.5;

// ── Food-category set (used to split tag blocks) ──────────────────────────────

const _foodCategories = {
  PlaceCategory.restaurant,
  PlaceCategory.cafe,
  PlaceCategory.bar,
  PlaceCategory.nightclub,
};

// ── Selection state ───────────────────────────────────────────────────────────

class MatchSelectionState {
  final Set<String> selectedPlaceTags;    // from non-food place descriptors
  final Set<String> selectedCuisineTags;  // from food-place descriptors
  final Set<PlaceCategory> selectedCategories;
  final List<PersonNode> selectedPersons;

  const MatchSelectionState({
    this.selectedPlaceTags = const {},
    this.selectedCuisineTags = const {},
    this.selectedCategories = const {},
    this.selectedPersons = const [],
  });

  bool get isEmpty =>
      selectedPlaceTags.isEmpty &&
      selectedCuisineTags.isEmpty &&
      selectedCategories.isEmpty &&
      selectedPersons.isEmpty;

  MatchSelectionState copyWith({
    Set<String>? selectedPlaceTags,
    Set<String>? selectedCuisineTags,
    Set<PlaceCategory>? selectedCategories,
    List<PersonNode>? selectedPersons,
  }) =>
      MatchSelectionState(
        selectedPlaceTags: selectedPlaceTags ?? this.selectedPlaceTags,
        selectedCuisineTags: selectedCuisineTags ?? this.selectedCuisineTags,
        selectedCategories: selectedCategories ?? this.selectedCategories,
        selectedPersons: selectedPersons ?? this.selectedPersons,
      );
}

class MatchSelectionNotifier extends Notifier<MatchSelectionState> {
  @override
  MatchSelectionState build() => const MatchSelectionState();

  void togglePlaceTag(String tag) {
    final s = Set<String>.from(state.selectedPlaceTags);
    if (!s.remove(tag)) s.add(tag);
    state = state.copyWith(selectedPlaceTags: s);
  }

  void toggleCuisineTag(String tag) {
    final s = Set<String>.from(state.selectedCuisineTags);
    if (!s.remove(tag)) s.add(tag);
    state = state.copyWith(selectedCuisineTags: s);
  }

  void toggleCategory(PlaceCategory cat) {
    final s = Set<PlaceCategory>.from(state.selectedCategories);
    if (!s.remove(cat)) s.add(cat);
    state = state.copyWith(selectedCategories: s);
  }

  void togglePerson(PersonNode person) {
    final list = List<PersonNode>.from(state.selectedPersons);
    final existed = list.any((p) => p.id == person.id);
    if (existed) {
      list.removeWhere((p) => p.id == person.id);
    } else {
      list.add(person);
    }
    state = state.copyWith(selectedPersons: list);
  }

  void clear() => state = const MatchSelectionState();
}

final matchSelectionProvider =
    NotifierProvider<MatchSelectionNotifier, MatchSelectionState>(
  MatchSelectionNotifier.new,
);

// ── Tag pools ─────────────────────────────────────────────────────────────────

/// Unique descriptor texts from non-food places (atmosphere / vibe tags).
final placeCharacteristicTagsProvider = FutureProvider<List<String>>((ref) async {
  final places = await ref.watch(placesProvider.future);
  final seen = <String>{};
  await Future.wait(
    places.where((p) => !_foodCategories.contains(p.category)).map((p) async {
      final descs = await ref.read(placeDescriptorsProvider(p.id).future);
      for (final d in descs) {
        seen.add(d.descriptor);
      }
    }),
  );
  return seen.toList()..sort();
});

/// Unique descriptor texts from food-category places (cuisine / taste tags).
final cuisineTagsProvider = FutureProvider<List<String>>((ref) async {
  final places = await ref.watch(placesProvider.future);
  final seen = <String>{};
  await Future.wait(
    places.where((p) => _foodCategories.contains(p.category)).map((p) async {
      final descs = await ref.read(placeDescriptorsProvider(p.id).future);
      for (final d in descs) {
        seen.add(d.descriptor);
      }
    }),
  );
  return seen.toList()..sort();
});

/// PlaceCategory values that actually exist among saved places, in enum order.
final savedCategoriesProvider = Provider<List<PlaceCategory>>((ref) {
  final places = ref.watch(placesProvider).valueOrNull ?? [];
  final seen = <PlaceCategory>{};
  for (final p in places) {
    seen.add(p.category);
  }
  return PlaceCategory.values.where(seen.contains).toList();
});

// ── Scored match result ───────────────────────────────────────────────────────

class MatchResult {
  final PlaceNode place;
  final double score;
  final List<String> matchedTags;

  const MatchResult({
    required this.place,
    required this.score,
    required this.matchedTags,
  });
}

/// Top-5 matching places for the current selection, sorted by score descending.
final matchResultsProvider = FutureProvider<List<MatchResult>>((ref) async {
  final selection = ref.watch(matchSelectionProvider);
  if (selection.isEmpty) return const [];

  final places = await ref.watch(placesProvider.future);

  // Pre-load all descriptors.
  final descriptorMap = <String, List<SemanticDescriptor>>{};
  await Future.wait(places.map((p) async {
    descriptorMap[p.id] =
        await ref.read(placeDescriptorsProvider(p.id).future);
  }));

  // Pre-load person tags for selected participants.
  final personTagMap = <String, List<String>>{};    // id → positive labels
  final personNegTagMap = <String, List<String>>{}; // id → negative labels
  await Future.wait(selection.selectedPersons.map((person) async {
    final tags = await ref.read(personTagsProvider(person.id).future);
    personTagMap[person.id] =
        tags.where((t) => t.sentiment.name == 'positive').map((t) => t.label).toList();
    personNegTagMap[person.id] =
        tags.where((t) => t.sentiment.name == 'negative').map((t) => t.label).toList();
  }));

  final allSelectedTags = {
    ...selection.selectedPlaceTags,
    ...selection.selectedCuisineTags,
  };

  final results = <MatchResult>[];

  for (final place in places) {
    final descs = descriptorMap[place.id] ?? [];
    final descTexts = descs.map((d) => d.descriptor.toLowerCase()).toList();
    double score = 0;
    final matched = <String>[];

    // Category match.
    if (selection.selectedCategories.contains(place.category)) {
      score += kCategoryMatchWeight;
    }

    // Selected tag matches against place descriptors.
    for (final d in descs) {
      if (allSelectedTags.contains(d.descriptor)) {
        final multiplier = d.source == DescriptorSource.userDefined
            ? kUserDefinedTagMultiplier
            : 1.0;
        score += d.weight * multiplier;
        matched.add(d.descriptor);
      }
    }

    // Person preference tag influences.
    for (final person in selection.selectedPersons) {
      final pos = personTagMap[person.id] ?? [];
      final neg = personNegTagMap[person.id] ?? [];
      for (final label in pos) {
        if (_tagMatchesAny(label, descTexts)) {
          score += kPersonPositiveTagWeight;
        }
      }
      for (final label in neg) {
        if (_tagMatchesAny(label, descTexts)) {
          score -= kPersonNegativeTagWeight;
        }
      }
    }

    // Personal score bonus.
    if (place.personalScore != null) {
      score += place.personalScore! * kPersonalScoreBonus;
    }

    if (score > 0) {
      results.add(MatchResult(place: place, score: score, matchedTags: matched));
    }
  }

  results.sort((a, b) => b.score.compareTo(a.score));
  return results.take(5).toList();
});

// ── Helpers ───────────────────────────────────────────────────────────────────

/// Returns true if [label] substring-matches any element in [descriptors].
bool _tagMatchesAny(String label, List<String> descriptors) {
  final l = label.toLowerCase();
  for (final d in descriptors) {
    if (d.contains(l) || l.contains(d)) return true;
  }
  return false;
}
