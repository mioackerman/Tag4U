import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/chat_message.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';
import 'package:uuid/uuid.dart';

// ── State ─────────────────────────────────────────────────────────────────────

class PlanningChatState {
  final List<ChatMessage> messages;
  final bool isLoading;

  /// True while the member-selection sheet should be open.
  final bool partySheetOpen;

  /// Members selected during the planning setup flow.
  final List<PersonNode> selectedMembers;

  /// Places selected during the planning setup flow.
  final List<PlaceNode> selectedPlaces;

  const PlanningChatState({
    required this.messages,
    this.isLoading = false,
    this.partySheetOpen = false,
    this.selectedMembers = const [],
    this.selectedPlaces = const [],
  });

  PlanningChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? partySheetOpen,
    List<PersonNode>? selectedMembers,
    List<PlaceNode>? selectedPlaces,
  }) {
    return PlanningChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      partySheetOpen: partySheetOpen ?? this.partySheetOpen,
      selectedMembers: selectedMembers ?? this.selectedMembers,
      selectedPlaces: selectedPlaces ?? this.selectedPlaces,
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

  /// Called when user taps the "派对推荐" skill button.
  void onPartySkillTap() {
    _replaceSkillChoices('好的，来规划一场聚会！🎉\n请选择参与人员。');
    state = state.copyWith(partySheetOpen: true);
  }

  void closePartySheet() {
    state = state.copyWith(partySheetOpen: false);
  }

  // ── Selection ───────────────────────────────────────────────────────────────

  /// Called after the member → place selection flow completes.
  void setMembersAndPlaces({
    required List<PersonNode> members,
    required List<PlaceNode> places,
  }) {
    state = state.copyWith(
      selectedMembers: members,
      selectedPlaces: places,
      partySheetOpen: false,
    );
  }

  void clearSelection() {
    state = state.copyWith(
      selectedMembers: [],
      selectedPlaces: [],
    );
  }

  // ── Free-form user message ──────────────────────────────────────────────────

  Future<void> sendUserMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    // Inject member/place context on the first user message after selection.
    final isFirstUserMsg =
        !state.messages.any((m) => m.role == MessageRole.user);
    final promptContent =
        (state.selectedMembers.isNotEmpty && isFirstUserMsg)
            ? await _buildContextPrompt(trimmed)
            : trimmed;

    _addMessage(ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.user,
      text: trimmed,      // shown in the chat bubble
      prompt: promptContent, // sent to the API (may include context)
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

  /// Builds a rich prompt that includes member preferences and selected places.
  Future<String> _buildContextPrompt(String userText) async {
    final members = state.selectedMembers;
    final places = state.selectedPlaces;

    final allTags = await Future.wait(
      members.map((m) => ref.read(personTagsProvider(m.id).future)),
    );

    final memberLines = List.generate(members.length, (i) {
      final m = members[i];
      final tags = allTags[i];
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
      return '${m.name}${m.mbti != null ? '（${m.mbti}）' : ''}：$tagText';
    }).join('\n');

    final allDescriptors = await Future.wait(
      places.map((p) => ref.read(placeDescriptorsProvider(p.id).future)),
    );

    final placeLines = places.isEmpty
        ? '无指定地点'
        : List.generate(places.length, (i) {
            final p = places[i];
            final descs = allDescriptors[i];
            final descText = descs.isEmpty
                ? ''
                : '，标签：${descs.map((d) => d.descriptor).join('、')}';
            final extra = [
              if (p.address != null) p.address!,
              if (p.priceLevel != null) '价位${p.priceLevel}',
              if (p.personalNote != null) p.personalNote!,
            ].join('；');
            return '- ${p.name}${extra.isNotEmpty ? '（$extra）' : ''}$descText';
          }).join('\n');

    return '''
参与人员（${members.length}人）及偏好：
$memberLines

指定地点：
$placeLines

用户需求：$userText
''';
  }

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
          .map((m) =>
              m.id == id ? m.copyWith(text: text, type: MessageType.text) : m)
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

  ChatMessage _assistantMsg(String text,
      {MessageType type = MessageType.text}) {
    return ChatMessage(
      id: _uuid.v4(),
      role: MessageRole.assistant,
      type: type,
      text: text,
      createdAt: DateTime.now(),
    );
  }

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
