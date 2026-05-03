import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/fused_tag.dart';
import 'package:tag4u/infrastructure/fusion/fusion_service.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';
import 'package:tag4u/presentation/providers/match_providers.dart';

// ── Service ───────────────────────────────────────────────────────────────────

/// Null when no API key is configured — matching page falls back to raw tags.
final fusionServiceProvider = Provider<FusionService?>((ref) {
  final client = ref.watch(anthropicClientProvider);
  if (client == null) return null;
  return FusionService(client);
});

// ── Fused tag pools ───────────────────────────────────────────────────────────

/// Fusion result for place-characteristic tags (atmosphere / vibe).
/// Falls back to one-to-one wrapping when AI is unavailable.
final fusedPlaceTagsProvider = FutureProvider<List<FusedTag>>((ref) async {
  final rawTags = await ref.watch(placeCharacteristicTagsProvider.future);
  if (rawTags.isEmpty) return const [];
  final service = ref.watch(fusionServiceProvider);
  if (service == null) {
    return rawTags
        .map((t) => FusedTag(displayLabel: t, originalLabels: [t]))
        .toList();
  }
  return service.fuse(rawTags);
});

/// Fusion result for cuisine / taste tags.
final fusedCuisineTagsProvider = FutureProvider<List<FusedTag>>((ref) async {
  final rawTags = await ref.watch(cuisineTagsProvider.future);
  if (rawTags.isEmpty) return const [];
  final service = ref.watch(fusionServiceProvider);
  if (service == null) {
    return rawTags
        .map((t) => FusedTag(displayLabel: t, originalLabels: [t]))
        .toList();
  }
  return service.fuse(rawTags);
});

// ── Expansion helpers ─────────────────────────────────────────────────────────

/// Maps displayLabel → original labels for place-characteristic fused tags.
final placeTagExpansionProvider =
    FutureProvider<Map<String, List<String>>>((ref) async {
  final fused = await ref.watch(fusedPlaceTagsProvider.future);
  return {for (final f in fused) f.displayLabel: f.originalLabels};
});

/// Maps displayLabel → original labels for cuisine fused tags.
final cuisineTagExpansionProvider =
    FutureProvider<Map<String, List<String>>>((ref) async {
  final fused = await ref.watch(fusedCuisineTagsProvider.future);
  return {for (final f in fused) f.displayLabel: f.originalLabels};
});
