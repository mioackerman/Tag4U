import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/presentation/pages/place_selection_page.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/providers/planning_chat_provider.dart';
import 'package:tag4u/presentation/widgets/chat_bubble.dart';
import 'package:tag4u/presentation/widgets/party_input_sheet.dart';

class PlanningPage extends ConsumerStatefulWidget {
  const PlanningPage({super.key});

  @override
  ConsumerState<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends ConsumerState<PlanningPage> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  /// Guard flag — prevents launching the selection flow more than once at a time.
  bool _flowInProgress = false;

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(planningChatProvider);
    final hasSelection = chatState.selectedMembers.isNotEmpty ||
        chatState.selectedPlaces.isNotEmpty;

    // Scroll to bottom whenever messages change
    ref.listen(planningChatProvider, (_, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      // Open the member-selection flow when notifier requests it
      if (next.partySheetOpen) {
        _startPlanningFlow(chatState: next);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('规划'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            tooltip: '重置对话',
            onPressed: () {
              ref.invalidate(planningChatProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Message list ────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: chatState.messages.length,
              itemBuilder: (_, i) =>
                  ChatBubble(message: chatState.messages[i]),
            ),
          ),

          const Divider(height: 1),

          // ── Selection pills (shown when members/places are set) ─────────
          if (hasSelection)
            _SelectionPillsBar(
              memberCount: chatState.selectedMembers.length,
              placeCount: chatState.selectedPlaces.length,
              onTap: () => _startPlanningFlow(chatState: chatState),
            ),

          // ── Chat input bar ──────────────────────────────────────────────
          _ChatInputBar(
            controller: _inputController,
            isLoading: chatState.isLoading,
            onSend: () {
              final text = _inputController.text.trim();
              if (text.isEmpty) return;
              _inputController.clear();
              ref.read(planningChatProvider.notifier).sendUserMessage(text);
            },
          ),
        ],
      ),
    );
  }

  // ── Planning selection flow ───────────────────────────────────────────────

  Future<void> _startPlanningFlow(
      {required PlanningChatState chatState}) async {
    if (_flowInProgress) return;
    _flowInProgress = true;

    // Immediately clear the flag so the listener doesn't re-fire
    ref.read(planningChatProvider.notifier).closePartySheet();

    try {
      final allPersons = ref.read(personsProvider).valueOrNull ?? [];
      final currentMembers = chatState.selectedMembers;
      final currentPlaces = chatState.selectedPlaces;

      if (!mounted) return;

      // Step 1 — Member selection
      final selectedIds = await showModalBottomSheet<Set<String>>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => PartyInputSheet(
          initialSelectedIds: currentMembers.map((m) => m.id).toSet(),
        ),
      );

      if (selectedIds == null || !mounted) return;

      final selectedMembers =
          allPersons.where((p) => selectedIds.contains(p.id)).toList();

      // Step 2 — Place selection
      final selectedPlaces = await Navigator.push<List<PlaceNode>>(
        context,
        MaterialPageRoute(
          builder: (_) =>
              PlaceSelectionPage(initialSelected: currentPlaces),
        ),
      );

      if (!mounted) return;

      ref.read(planningChatProvider.notifier).setMembersAndPlaces(
            members: selectedMembers,
            places: selectedPlaces ?? [],
          );
    } finally {
      _flowInProgress = false;
    }
  }
}

// ── Selection pills ───────────────────────────────────────────────────────────

class _SelectionPillsBar extends StatelessWidget {
  final int memberCount;
  final int placeCount;
  final VoidCallback onTap;

  const _SelectionPillsBar({
    required this.memberCount,
    required this.placeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .primaryContainer
              .withOpacity(0.3),
        ),
        child: Row(
          children: [
            _Pill(
                icon: Icons.people_outline,
                label: '$memberCount 人',
                color: primary),
            const SizedBox(width: 8),
            _Pill(
                icon: Icons.place_outlined,
                label: '$placeCount 地点',
                color: secondary),
            const Spacer(),
            Icon(Icons.edit_outlined,
                size: 16, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Pill(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }
}

// ── Input bar ─────────────────────────────────────────────────────────────────

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  const _ChatInputBar({
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => isLoading ? null : onSend(),
                enabled: !isLoading,
                decoration: InputDecoration(
                  hintText: '发消息…',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHigh,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton.filled(
                      icon: const Icon(Icons.arrow_upward_rounded),
                      style: IconButton.styleFrom(
                        minimumSize: const Size(44, 44),
                        shape: const CircleBorder(),
                      ),
                      onPressed: onSend,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
