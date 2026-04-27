import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/chat_message.dart';
import 'package:tag4u/presentation/providers/planning_chat_provider.dart';

class ChatBubble extends ConsumerWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  bool get _isUser => message.role == MessageRole.user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: _isUser ? 64 : 16,
        right: _isUser ? 16 : 64,
      ),
      child: Align(
        alignment: _isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: _buildContent(context, ref),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    switch (message.type) {
      case MessageType.loading:
        return _BubbleContainer(
          color: scheme.surfaceContainerHigh,
          child: const _LoadingDots(),
        );

      case MessageType.skillChoices:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BubbleContainer(
              color: scheme.surfaceContainerHigh,
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
            _SkillButtonRow(),
          ],
        );

      case MessageType.text:
        return _BubbleContainer(
          color: _isUser
              ? scheme.primary
              : scheme.surfaceContainerHigh,
          child: Text(
            message.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _isUser ? scheme.onPrimary : scheme.onSurface,
                ),
          ),
        );
    }
  }
}

// ── Skill buttons (rendered inline inside assistant bubble) ───────────────────

class _SkillButtonRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _SkillChip(
          icon: Icons.celebration_outlined,
          label: '派对推荐',
          onTap: () =>
              ref.read(planningChatProvider.notifier).onPartySkillTap(),
        ),
        _SkillChip(
          icon: Icons.map_outlined,
          label: '行程规划',
          onTap: null, // coming soon
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SkillChip(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ActionChip(
      avatar: Icon(icon, size: 18,
          color: onTap == null ? scheme.outline : scheme.primary),
      label: Text(label),
      side: BorderSide(
          color: onTap == null ? scheme.outlineVariant : scheme.primary),
      labelStyle: TextStyle(
          color: onTap == null ? scheme.outline : scheme.primary,
          fontWeight: FontWeight.w600),
      onPressed: onTap,
    );
  }
}

// ── Shared container ──────────────────────────────────────────────────────────

class _BubbleContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const _BubbleContainer({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}

// ── Loading animation ─────────────────────────────────────────────────────────

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 20,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            final offset = ((_anim.value + i / 3) % 1.0);
            final scale = 0.5 + 0.5 * (1 - (offset - 0.5).abs() * 2).clamp(0.0, 1.0);
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
