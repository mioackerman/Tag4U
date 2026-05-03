import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';
import 'package:tag4u/presentation/providers/fusion_providers.dart';
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
  final Set<String> selectedPlaceTags;
  final Set<String> selectedCuisineTags;
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
final placeCharacteristicTagsProvider =
    FutureProvider<List<String>>((ref) async {
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
///
/// Scoring layers (all additive):
///   1. Category match
///   2. Selected tag match (with Fusion expansion + user-defined multiplier)
///   3. Person positive/negative preference tags
///   4. Personal score bonus
final matchResultsProvider = FutureProvider<List<MatchResult>>((ref) async {
  final selection = ref.watch(matchSelectionProvider);
  if (selection.isEmpty) return const [];

  final places = await ref.watch(placesProvider.future);

  // Resolve fused tag expansions (display label → original descriptor labels).
  final placeExpansion = await ref.watch(placeTagExpansionProvider.future);
  final cuisineExpansion = await ref.watch(cuisineTagExpansionProvider.future);

  // Expand selected fused display labels back to original descriptor strings.
  final expandedSelectedTags = <String>{};
  for (final label in selection.selectedPlaceTags) {
    expandedSelectedTags.addAll(placeExpansion[label] ?? [label]);
  }
  for (final label in selection.selectedCuisineTags) {
    expandedSelectedTags.addAll(cuisineExpansion[label] ?? [label]);
  }

  // Pre-load all descriptors.
  final descriptorMap = <String, List<SemanticDescriptor>>{};
  await Future.wait(places.map((p) async {
    descriptorMap[p.id] = await ref.read(placeDescriptorsProvider(p.id).future);
  }));

  // Pre-load person preference tags for selected participants.
  final personTagMap = <String, List<String>>{};    // id → positive labels
  final personNegTagMap = <String, List<String>>{}; // id → negative labels
  await Future.wait(selection.selectedPersons.map((person) async {
    final tags = await ref.read(personTagsProvider(person.id).future);
    personTagMap[person.id] = tags
        .where((t) => t.sentiment.name == 'positive')
        .map((t) => t.label)
        .toList();
    personNegTagMap[person.id] = tags
        .where((t) => t.sentiment.name == 'negative')
        .map((t) => t.label)
        .toList();
  }));

  final results = <MatchResult>[];

  for (final place in places) {
    final descs = descriptorMap[place.id] ?? [];
    final descTexts = descs.map((d) => d.descriptor.toLowerCase()).toList();
    double score = 0;
    final matched = <String>[];

    // 1. Category match.
    if (selection.selectedCategories.contains(place.category)) {
      score += kCategoryMatchWeight;
    }

    // 2. Selected tag matches (uses Fusion-expanded original descriptors).
    for (final d in descs) {
      if (expandedSelectedTags.contains(d.descriptor)) {
        final multiplier = d.source == DescriptorSource.userDefined
            ? kUserDefinedTagMultiplier
            : 1.0;
        score += d.weight * multiplier;
        matched.add(d.descriptor);
      }
    }

    // 3. Person preference tag influences.
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

    // 4. Personal score bonus.
    if (place.personalScore != null) {
      score += place.personalScore! * kPersonalScoreBonus;
    }

    if (score > 0) {
      results.add(
          MatchResult(place: place, score: score, matchedTags: matched));
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

// ── AI Recommend ──────────────────────────────────────────────────────────────

class AiPlaceResult {
  final PlaceNode place;
  final String reason;
  final int rank;

  const AiPlaceResult({
    required this.place,
    required this.reason,
    required this.rank,
  });
}

class AiMatchState {
  final List<PersonNode> participants;
  final List<({String role, String text})> messages;
  final List<AiPlaceResult>? results;
  final bool isLoading;
  final String? error;

  const AiMatchState({
    this.participants = const [],
    this.messages = const [],
    this.results,
    this.isLoading = false,
    this.error,
  });

  bool get hasResults => results != null;

  AiMatchState copyWith({
    List<PersonNode>? participants,
    List<({String role, String text})>? messages,
    List<AiPlaceResult>? results,
    bool clearResults = false,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      AiMatchState(
        participants: participants ?? this.participants,
        messages: messages ?? this.messages,
        results: clearResults ? null : results ?? this.results,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : error ?? this.error,
      );
}

final aiMatchProvider =
    NotifierProvider<AiMatchNotifier, AiMatchState>(AiMatchNotifier.new);

class AiMatchNotifier extends Notifier<AiMatchState> {
  @override
  AiMatchState build() => const AiMatchState();

  void toggleParticipant(PersonNode person) {
    final list = List<PersonNode>.from(state.participants);
    if (list.any((p) => p.id == person.id)) {
      list.removeWhere((p) => p.id == person.id);
    } else {
      list.add(person);
    }
    state = state.copyWith(participants: list);
  }

  void clearResults() =>
      state = state.copyWith(clearResults: true, clearError: true);

  Future<void> recommend(String activityText) async {
    final client = ref.read(anthropicClientProvider);
    if (client == null) {
      state = state.copyWith(error: '未配置 API Key，无法使用 AI 推荐');
      return;
    }

    final userMsg = (
      role: 'user',
      text: activityText.trim().isEmpty ? '帮我推荐今天适合去的地方' : activityText.trim(),
    );
    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isLoading: true,
      clearResults: true,
      clearError: true,
    );

    try {
      // Build participant context.
      final participantLines = <String>[];
      for (final person in state.participants) {
        final tagsResult =
            await ref.read(personTagsProvider(person.id).future);
        final tagLabels = tagsResult.map((t) => t.label).join(', ');
        participantLines.add(
            '- ${person.name}${tagLabels.isNotEmpty ? '（$tagLabels）' : ''}');
      }

      // Build places context.
      final places = await ref.read(placesProvider.future);
      final placeLines = <String>[];
      for (final place in places) {
        final descs =
            await ref.read(placeDescriptorsProvider(place.id).future);
        final descText = descs.map((d) => d.descriptor).join('、');
        placeLines.add(
            '[id:${place.id}] ${place.name}（${descText.isNotEmpty ? descText : '暂无描述'}）');
      }

      final prompt = '''参与人：
${participantLines.isEmpty ? '（未指定）' : participantLines.join('\n')}

活动描述：${userMsg.text}

可选地点：
${placeLines.join('\n')}''';

      final raw = await client.recommendPlaces(userMessage: prompt);

      // Parse JSON response.
      final placeMap = {for (final p in places) p.id: p};
      List<AiPlaceResult> results = [];
      try {
        final jsonStr =
            raw.replaceAll(RegExp(r'^```json\s*', multiLine: true), '')
               .replaceAll(RegExp(r'^```\s*$', multiLine: true), '')
               .trim();
        final list = jsonDecode(jsonStr) as List<dynamic>;
        results = list
            .map((e) {
              final m = e as Map<String, dynamic>;
              final place = placeMap[m['placeId'] as String?];
              if (place == null) return null;
              return AiPlaceResult(
                place: place,
                reason: (m['reason'] as String?) ?? '',
                rank: (m['rank'] as int?) ?? 0,
              );
            })
            .whereType<AiPlaceResult>()
            .toList()
          ..sort((a, b) => a.rank.compareTo(b.rank));
      } catch (_) {
        // If JSON parse fails, show raw response as a message.
        state = state.copyWith(
          messages: [
            ...state.messages,
            (role: 'assistant', text: raw),
          ],
          isLoading: false,
        );
        return;
      }

      state = state.copyWith(
        messages: [
          ...state.messages,
          (role: 'assistant', text: 'AI 已为你排序出 ${results.length} 个地点推荐。'),
        ],
        results: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'AI 出错：$e',
        isLoading: false,
      );
    }
  }
}
