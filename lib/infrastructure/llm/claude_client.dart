import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tag4u/infrastructure/llm/llm_client.dart';

class ClaudeClient extends LLMClient {
  final String apiKey;
  final String model;
  final http.Client _http;

  static const _endpoint = 'https://api.anthropic.com/v1/messages';
  static const _anthropicVersion = '2023-06-01';

  ClaudeClient({
    required this.apiKey,
    this.model = 'claude-sonnet-4-6',
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  @override
  Future<String> generate({
    required String systemPrompt,
    required List<Map<String, String>> messages,
    int maxTokens = 512,
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
        'anthropic-version': _anthropicVersion,
        'anthropic-beta': 'prompt-caching-2024-07-31',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw LLMException(statusCode: response.statusCode, body: response.body);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final content = json['content'] as List<dynamic>;
    final block = (content.first as Map<String, dynamic>);
    return block['text'] as String;
  }

  @override
  void dispose() => _http.close();
}
