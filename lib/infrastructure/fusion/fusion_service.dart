import 'dart:convert';
import 'package:tag4u/domain/entities/fused_tag.dart';
import 'package:tag4u/infrastructure/llm/llm_client.dart';

/// Semantically groups similar tags into [FusedTag]s using AI.
///
/// This is a display-layer service only — it never reads or writes the
/// database. Original tags are always preserved as-is.
///
/// Results are cached in memory keyed by the sorted tag fingerprint, so
/// repeated calls for the same tag set are free.
class FusionService {
  final LLMClient _client;
  final _cache = <String, List<FusedTag>>{};

  FusionService(this._client);

  Future<List<FusedTag>> fuse(List<String> tags) async {
    if (tags.isEmpty) return const [];
    if (tags.length == 1) {
      return [FusedTag(displayLabel: tags.first, originalLabels: tags)];
    }

    final cacheKey = (List<String>.from(tags)..sort()).join('|');
    if (_cache.containsKey(cacheKey)) return _cache[cacheKey]!;

    try {
      final result = await _callAI(tags);
      _cache[cacheKey] = result;
      return result;
    } catch (_) {
      // Degrade gracefully: each tag is its own solo group.
      return tags
          .map((t) => FusedTag(displayLabel: t, originalLabels: [t]))
          .toList();
    }
  }

  Future<List<FusedTag>> _callAI(List<String> tags) async {
    final tagsJson = jsonEncode(tags);
    final prompt =
        'Group the following user-defined place/activity tags by semantic similarity. '
        'Only merge tags that clearly mean the same or very similar thing — when in doubt, keep them separate. '
        'The "display" field MUST be one of the original tags (choose the most descriptive). '
        'Every original tag must appear in exactly one group. '
        'Return only valid JSON, no other text.\n\n'
        'Tags: $tagsJson\n\n'
        'Format: {"groups": [{"display": "chosen original label", "originals": ["label1", "label2"]}]}';

    final response = await _client.fuseTags(userMessage: prompt);

    // Extract JSON object from the response.
    final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(response);
    if (jsonMatch == null) throw const FormatException('no JSON in fusion response');

    final parsed = jsonDecode(jsonMatch.group(0)!) as Map<String, dynamic>;
    final groups = (parsed['groups'] as List<dynamic>);

    final fusedTags = groups.map((g) {
      final m = g as Map<String, dynamic>;
      return FusedTag(
        displayLabel: m['display'] as String,
        originalLabels: (m['originals'] as List<dynamic>).cast<String>(),
      );
    }).toList();

    // Safety: re-add any tags the AI dropped.
    final covered = fusedTags.expand((f) => f.originalLabels).toSet();
    for (final missed in tags.where((t) => !covered.contains(t))) {
      fusedTags.add(FusedTag(displayLabel: missed, originalLabels: [missed]));
    }

    return fusedTags;
  }
}
