import 'dart:convert';
import 'package:http/http.dart' as http;

/// Thin HTTP client for the Anthropic Messages API.
///
/// Enables prompt caching on the system prompt to reduce cost on repeated
/// itinerary calls (same system context, different user payloads).
class AnthropicClient {
  final String apiKey;
  final String model;
  final http.Client _http;

  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _apiVersion = '2023-06-01';
  static const _cachingBeta = 'prompt-caching-2024-07-31';

  /// System prompt for single-turn itinerary synthesis — cached.
  static const _itinerarySystemPrompt =
      'You are a concise travel and activity planning assistant. '
      'Given a list of candidate places, a group size, and an optional activity hint, '
      'produce a practical, friendly itinerary in Markdown. '
      'Include timing suggestions, transition tips, and one sentence per venue '
      'explaining why it suits the group. '
      'Keep the total response under 400 words. Respond in the same language as the activity hint if provided, otherwise use English.';

  /// System prompt for the multi-turn planning chat — cached.
  static const _chatSystemPrompt =
      'You are Tag4U, a smart and friendly group activity planning assistant embedded in a mobile app. '
      'You help groups decide where to go and what to do, based on each person\'s stored preference tags. '
      'When recommending venues or activities, format your response as a concise numbered list '
      'with a one-sentence reason per item that references the group\'s actual preferences. '
      'If you need more information, ask one clear question. '
      'Be warm, practical, and avoid filler text. '
      'Respond in the same language the user writes in.';

  AnthropicClient({
    required this.apiKey,
    this.model = 'claude-haiku-4-5-20251001',
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  /// Single-turn itinerary synthesis.
  Future<String> complete({
    required String userMessage,
    int maxTokens = 512,
  }) async {
    return _call(
      systemPrompt: _itinerarySystemPrompt,
      messages: [
        {'role': 'user', 'content': userMessage}
      ],
      maxTokens: maxTokens,
    );
  }

  /// Multi-turn planning chat.
  ///
  /// [messages] — full conversation history in
  /// `[{role: 'user'|'assistant', content: '...'}]` format.
  Future<String> chat({
    required List<Map<String, String>> messages,
    int maxTokens = 1024,
  }) async {
    return _call(
      systemPrompt: _chatSystemPrompt,
      messages: messages,
      maxTokens: maxTokens,
    );
  }

  Future<String> _call({
    required String systemPrompt,
    required List<Map<String, String>> messages,
    required int maxTokens,
  }) async {
    final body = jsonEncode({
      'model': model,
      'max_tokens': maxTokens,
      'system': [
        {
          'type': 'text',
          'text': systemPrompt,
          'cache_control': {'type': 'ephemeral'},
        }
      ],
      'messages': messages,
    });

    final response = await _http.post(
      Uri.parse(_endpoint),
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': _apiVersion,
        'anthropic-beta': _cachingBeta,
        'content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw AnthropicException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final content = json['content'] as List<dynamic>;
    return (content.first as Map<String, dynamic>)['text'] as String;
  }

  void dispose() => _http.close();
}

class AnthropicException implements Exception {
  final int statusCode;
  final String body;

  const AnthropicException({required this.statusCode, required this.body});

  @override
  String toString() => 'AnthropicException($statusCode): $body';
}
