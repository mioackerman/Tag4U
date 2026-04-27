import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(planningChatProvider);

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

      // Open party sheet when notifier requests it
      if (next.partySheetOpen) {
        _showPartySheet();
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
            onPressed: () => ref.invalidate(planningChatProvider),
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

          // ── Input bar ───────────────────────────────────────────────────
          _ChatInputBar(
            controller: _inputController,
            isLoading: chatState.isLoading,
            onSend: () {
              final text = _inputController.text.trim();
              if (text.isEmpty) return;
              _inputController.clear();
              ref
                  .read(planningChatProvider.notifier)
                  .sendUserMessage(text);
            },
          ),
        ],
      ),
    );
  }

  void _showPartySheet() {
    // Guard: don't stack multiple sheets
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const PartyInputSheet(),
    ).whenComplete(() {
      // If user dismisses sheet without submitting, close the flag
      ref.read(planningChatProvider.notifier).closePartySheet();
    });
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
                  fillColor:
                      Theme.of(context).colorScheme.surfaceContainerHigh,
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
                          child: CircularProgressIndicator(strokeWidth: 2)),
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
