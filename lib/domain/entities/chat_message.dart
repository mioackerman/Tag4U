import 'package:equatable/equatable.dart';

enum MessageRole { user, assistant }

/// How the bubble renders.
enum MessageType {
  /// Plain text (default).
  text,

  /// Assistant bubble that includes inline skill-action chips.
  skillChoices,

  /// Animated loading dots while waiting for the AI response.
  loading,
}

class ChatMessage extends Equatable {
  final String id;
  final MessageRole role;
  final MessageType type;

  /// Text shown in the UI.
  final String text;

  /// Full prompt sent to the API when different from [text].
  /// Used for party-planning submissions where the display is a short summary
  /// but the API receives full preference context.
  final String? prompt;

  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.role,
    this.type = MessageType.text,
    required this.text,
    this.prompt,
    required this.createdAt,
  });

  bool get isLoading => type == MessageType.loading;

  /// Content actually sent to Claude.
  String get apiContent => prompt ?? text;

  ChatMessage copyWith({
    String? text,
    MessageType? type,
    String? prompt,
  }) {
    return ChatMessage(
      id: id,
      role: role,
      type: type ?? this.type,
      text: text ?? this.text,
      prompt: prompt ?? this.prompt,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, role, type, text, prompt, createdAt];
}
