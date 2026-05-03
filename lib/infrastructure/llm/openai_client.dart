import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tag4u/infrastructure/llm/llm_client.dart';

class OpenAIClient extends LLMClient {
  final String apiKey;
  final String model;
  final http.Client _http;

  static const _endpoint = 'https://api.openai.com/v1/responses';

  OpenAIClient({
    required this.apiKey,
    this.model = 'gpt-5.2',
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  @override
  Future<String> generate({
    required String systemPrompt,
    required List<Map<String, String>> messages,
    int maxTokens = 512,
  }) async {
    final input = messages
        .map((m) => {
              'role': m['role'] ?? 'user',
              'content': m['content'] ?? '',
            })
        .toList();

    final body = jsonEncode({
      'model': model,
      'instructions': systemPrompt,
      'input': input,
      'max_output_tokens': maxTokens,
    });

    final response = await _http.post(
      Uri.parse(_endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LLMException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final outputText = data['output_text'];
    if (outputText is String && outputText.isNotEmpty) {
      return outputText;
    }

    final output = data['output'];
    if (output is List) {
      final buffer = StringBuffer();

      for (final item in output) {
        if (item is! Map<String, dynamic>) continue;

        final content = item['content'];
        if (content is! List) continue;

        for (final c in content) {
          if (c is Map<String, dynamic>) {
            final text = c['text'];
            if (text is String) buffer.write(text);
          }
        }
      }

      final result = buffer.toString();
      if (result.isNotEmpty) return result;
    }

    throw LLMException(
      statusCode: response.statusCode,
      body: 'OpenAI response did not contain output text: ${response.body}',
    );
  }

  @override
  void dispose() => _http.close();
}