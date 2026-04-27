import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/chat_message.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';
import 'package:uuid/uuid.dart';

// ── State ─────────────────────────────────────────────────────────────────────

class PlanningChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  /// True while the party-input bottom sheet should be open.
  final bool partySheetOpen;

  const PlanningChatState({
    required this.messages,
    this.isLoading = false,
    this.partySheetOpen = false,
  });

  PlanningChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? partySheetOpen,
  }) {
    return PlanningChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      partySheetOpen: partySheetOpen ?? this.partySheetOpen,
    );
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

final planningChatProvider =
    NotifierProvider<PlanningChatNotifier, PlanningChatState>(
  PlanningChatNotifier.new,
);

// ── Notifier ──────────────────────────────────────────────────────────────────

class PlanningChatNotifier extends Notifier<PlanningChatState> {
  static const _uuid = Uuid();

  @override
  PlanningChatState build() {
    return PlanningChatState(
      messages: [
        _assistantMsg(
          '你好！我是 Tag4U 规划助手。\n今天想做什么？',
          type: MessageType.skillChoices,
        ),
      ],
    );
  }

  // ── Skill triggers ──────────────────────────────────────────────────────────

  /// Called when user taps "派对推荐" skill button.
  void onPartySkillTap() {
    // Replace the skill-choices bubble with a plain confirmation
    _replaceSkillChoices('好的，来规划一场聚会！🎉\n请选择参与人员并描述活动内容。');
    state = state.copyWith(partySheetOpen: true);
  }

  void closePartySheet() {
    state = state.copyWith(partySheetOpen: false);
  }

  // ── Party planning submission ───────────────────────────────────────────────

  /// Called when user confirms the party-input sheet.
  ///
  /// [members]     — selected [PersonNode]s.
  /// [tagsByPerson] — preferenceTags grouped by personNodeId.
  /// [description] — free-text activity description.
  Future<void> submitPartyPlanning({
    required List<PersonNode> members,
    required Map<String, List<PreferenceTag>> tagsByPerson,
    required String description,
  }) async {
    state = state.copyWith(partySheetOpen: false);

    // Build a short display label for the user bubble
    final nameList = members.map((m) => m.name).join('、');
    final displayText = members.isEmpty
        ? description
        : '$nameList 参与\n$description';

    // Build the full prompt with preference context for Claude
    final prefLines = members.map((m) {
      final tags = tagsByPerson[m.id] ?? [];
      final tagText = tags.isEmpty
          ? '无特别偏好'
          : tags.map((t) {
              final prefix = switch (t.sentiment) {
                TagSentiment.positive => '喜欢',
                TagSentiment.negative => '不喜欢',
                TagSentiment.neutral => '',
              };
              return '$prefix${t.label}';
            }).join('，');
      return '${m.name}（${m.gender ?? ''}${m.mbti != null ? ' · ${m.mbti}' : ''}）：$tagText';
    }).join('\n');

    final fullPrompt = '''
帮我规划一场聚会活动。

参与人员及偏好：
$prefLines

活动需求：$description

请根据大家的偏好推荐 5-8 个适合的场所或活动类型，给出简短理由。
''';

    _addMessage(ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
      text: displayText,
      prompt: fullPrompt,
      createdAt: DateTime.now(),
    ));

    final loadingId = _addLoading();

    try {
      final client = ref.read(anthropicClientProvider);
      if (client == null) {
        _resolveLoading(
            loadingId, '⚠️ 请先在 .env 文件中填写 ANTHROPIC_API_KEY。');
        return;
      }
      final response = await client.chat(messages: _apiHistory());
      _resolveLoading(loadingId, response);
    } on Exception catch (e) {
      _resolveLoading(loadingId, '出错了：$e');
    }
  }

  // ── Free-form user message ──────────────────────────────────────────────────

  Future<void> sendUserMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    _addMessage(ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
      text: trimmed,
      createdAt: DateTime.now(),
    ));

    final loadingId = _addLoading();

    try {
      final client = ref.read(anthropicClientProvider);
      if (client == null) {
        _resolveLoading(
            loadingId, '⚠️ 请先在 .env 文件中填写 ANTHROPIC_API_KEY。');
        return;
      }
      final response = await client.chat(messages: _apiHistory());
      _resolveLoading(loadingId, response);
    } on Exception catch (e) {
      _resolveLoading(loadingId, '出错了：$e');
    }
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  void _addMessage(ChatMessage msg) {
    state = state.copyWith(messages: [...state.messages, msg]);
  }

  String _addLoading() {
    final id = _uuid.v4();
    _addMessage(ChatMessage(
      id: id,
      role: MessageRole.assistant,
      type: MessageType.loading,
      text: '',
      createdAt: DateTime.now(),
    ));
    state = state.copyWith(isLoading: true);
    return id;
  }

  void _resolveLoading(String id, String text) {
    state = state.copyWith(
      messages: state.messages
          .map((m) => m.id == id ? m.copyWith(text: text, type: MessageType.text) : m)
          .toList(),
      isLoading: false,
    );
  }

  void _replaceSkillChoices(String newText) {
    state = state.copyWith(
      messages: state.messages
          .map((m) => m.type == MessageType.skillChoices
              ? m.copyWith(text: newText, type: MessageType.text)
              : m)
          .toList(),
    );
  }

  ChatMessage _assistantMsg(String text, {MessageType type = MessageType.text}) {
    return ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.assistant,
      type: type,
      text: text,
      createdAt: DateTime.now(),
    );
  }

  /// Builds the API message history (excludes loading bubbles).
  List<Map<String, String>> _apiHistory() {
    return state.messages
        .where((m) => !m.isLoading && m.text.isNotEmpty)
        .map((m) => {
              'role': m.role == MessageRole.user ? 'user' : 'assistant',
              'content': m.apiContent,
            })
        .toList();
  }
}
