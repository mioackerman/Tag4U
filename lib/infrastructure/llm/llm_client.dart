/// Abstract LLM interface. Concrete providers implement [generate]; all
/// high-level convenience methods are defined here and call [generate].
abstract class LLMClient {
  // ── System prompts ────────────────────────────────────────────────────────

  static const _recommendSystemPrompt =
      'You are a place recommendation assistant for group outings. '
      'Given participant preference tags and a list of saved places with descriptors, '
      'rank the top 5 most suitable places for the described activity. '
      'Return ONLY a valid JSON array with no markdown or extra text: '
      '[{"placeId":"...","placeName":"...","reason":"one sentence","rank":1}]. '
      'Rank 1 = best match. At most 5 results. '
      'Respond reasons in the same language the activity description is written in.';

  static const _fusionSystemPrompt =
      'You are a semantic tag deduplication assistant. '
      'Your only task is to group user-provided tags by semantic similarity and return valid JSON. '
      'Never invent new labels. Never modify the original text. Return JSON only.';

  static const _chatSystemPrompt =
      'You are Tag4U, a smart and friendly group activity planning assistant embedded in a mobile app. '
      'You help groups decide where to go and what to do, based on each person\'s stored preference tags. '
      'When recommending venues or activities, format your response as a concise numbered list '
      'with a one-sentence reason per item that references the group\'s actual preferences. '
      'If you need more information, ask one clear question. '
      'Be warm, practical, and avoid filler text. '
      'Respond in the same language the user writes in.';

  static const _itinerarySystemPrompt =
      'You are a concise travel and activity planning assistant. '
      'Given a list of candidate places, a group size, and an optional activity hint, '
      'produce a practical, friendly itinerary in Markdown. '
      'Include timing suggestions, transition tips, and one sentence per venue '
      'explaining why it suits the group. '
      'Keep the total response under 400 words. '
      'Respond in the same language as the activity hint if provided, otherwise use English.';

  // ── Abstract core ─────────────────────────────────────────────────────────

  /// Send [messages] with a [systemPrompt] and return the model's text reply.
  Future<String> generate({
    required String systemPrompt,
    required List<Map<String, String>> messages,
    int maxTokens = 512,
  });

  // ── Convenience methods ───────────────────────────────────────────────────

  Future<String> recommendPlaces({
    required String userMessage,
    int maxTokens = 768,
  }) =>
      generate(
        systemPrompt: _recommendSystemPrompt,
        messages: [
          {'role': 'user', 'content': userMessage}
        ],
        maxTokens: maxTokens,
      );

  Future<String> fuseTags({
    required String userMessage,
    int maxTokens = 512,
  }) =>
      generate(
        systemPrompt: _fusionSystemPrompt,
        messages: [
          {'role': 'user', 'content': userMessage}
        ],
        maxTokens: maxTokens,
      );

  Future<String> chat({
    required List<Map<String, String>> messages,
    int maxTokens = 1024,
  }) =>
      generate(
        systemPrompt: _chatSystemPrompt,
        messages: messages,
        maxTokens: maxTokens,
      );

  Future<String> complete({
    required String userMessage,
    int maxTokens = 512,
  }) =>
      generate(
        systemPrompt: _itinerarySystemPrompt,
        messages: [
          {'role': 'user', 'content': userMessage}
        ],
        maxTokens: maxTokens,
      );

  void dispose() {}
}

// ── Shared exception ──────────────────────────────────────────────────────────

class LLMException implements Exception {
  final int statusCode;
  final String body;

  const LLMException({required this.statusCode, required this.body});

  @override
  String toString() => 'LLMException($statusCode): $body';
}
