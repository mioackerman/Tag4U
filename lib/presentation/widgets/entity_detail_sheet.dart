import 'package:flutter/material.dart';

/// Generic layout shell for all entity detail bottom sheets.
///
/// Renders: drag handle (+ optional delete icon) → [header] → [sections].
/// Concrete entity sheets (PersonDetailSheet, PlaceDetailSheet) use this
/// as their layout root and inject entity-specific sections.
class EntityDetailSheet extends StatelessWidget {
  final Widget header;

  /// Body sections; a [Divider] is automatically inserted between them.
  final List<Widget> sections;

  /// When provided, a delete icon appears at the top-right of the sheet.
  /// Called after the user confirms the deletion; the sheet is closed
  /// automatically after this callback returns.
  final VoidCallback? onDelete;

  const EntityDetailSheet({
    super.key,
    required this.header,
    required this.sections,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Shift the sheet up by the keyboard height so text fields are always
    // visible. DraggableScrollableSheet doesn't observe viewInsets on its own.
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: DraggableScrollableSheet(
        initialChildSize: 0.78,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (ctx, sc) => Column(
          children: [
            _HandleRow(
              onDelete: onDelete == null ? null : () => _confirmDelete(ctx),
            ),
            Expanded(
              child: ListView(
                controller: sc,
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 48),
                children: [
                  header,
                  const SizedBox(height: 24),
                  for (int i = 0; i < sections.length; i++) ...[
                    if (i > 0) const Divider(height: 36),
                    sections[i],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('此操作不可撤销。'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('取消')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade400),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      onDelete!();
      Navigator.pop(context);
    }
  }
}

/// Reusable inline-editable name + avatar header used by all entity sheets.
///
/// Manages editing state internally; calls [onSave] only when the name
/// actually changed and is non-empty.
class EntityNameHeader extends StatefulWidget {
  final Widget avatar;
  final String name;
  final void Function(String) onSave;

  const EntityNameHeader({
    super.key,
    required this.avatar,
    required this.name,
    required this.onSave,
  });

  @override
  State<EntityNameHeader> createState() => _EntityNameHeaderState();
}

class _EntityNameHeaderState extends State<EntityNameHeader> {
  bool _editing = false;
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.name);
  }

  @override
  void didUpdateWidget(EntityNameHeader old) {
    super.didUpdateWidget(old);
    if (!_editing) _ctrl.text = widget.name;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _commit() {
    final name = _ctrl.text.trim();
    setState(() => _editing = false);
    if (name.isNotEmpty && name != widget.name) widget.onSave(name);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.avatar,
        const SizedBox(width: 14),
        Expanded(
          child: _editing
              ? TextField(
                  controller: _ctrl,
                  autofocus: true,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _commit(),
                  onTapOutside: (_) => _commit(),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    border: UnderlineInputBorder(),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    _ctrl.text = widget.name;
                    setState(() => _editing = true);
                  },
                  child: Text(
                    widget.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
        ),
      ],
    );
  }
}

/// Titled section used inside [EntityDetailSheet].
/// Renders: label → 12px gap → [child].
class DetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        detailSectionLabel(context, title),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

/// Generic "add tag" row used at the bottom of every entity detail sheet.
///
/// [extra] is rendered above the input row — use it for entity-specific
/// controls like a sentiment selector.
class EntityAddTagSection extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onSubmit;
  final Widget? extra;

  const EntityAddTagSection({
    super.key,
    required this.controller,
    required this.hint,
    required this.onSubmit,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return DetailSection(
      title: '添加标签',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (extra != null) ...[extra!, const SizedBox(height: 10)],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => onSubmit(),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: onSubmit,
                style: FilledButton.styleFrom(
                    minimumSize: const Size(56, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tappable chip for basic-info fields (category, address, note, etc.).
class DetailInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const DetailInfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

/// Shared primary-colored section title style.
Widget detailSectionLabel(BuildContext context, String text) => Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
    );

/// Shared single-field edit dialog used by basic-info chips.
void showEditTextDialog(
  BuildContext context, {
  required String title,
  required String hint,
  required String? current,
  required void Function(String) onSave,
}) {
  final ctrl = TextEditingController(text: current ?? '');
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: ctrl,
        autofocus: true,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            onSave(ctrl.text.trim());
          },
          child: const Text('保存'),
        ),
      ],
    ),
  );
}

// ── Private ───────────────────────────────────────────────────────────────────

/// Handle bar row: centered drag indicator + optional right-aligned delete icon.
class _HandleRow extends StatelessWidget {
  final VoidCallback? onDelete;
  const _HandleRow({this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 4),
      child: Row(
        children: [
          const SizedBox(width: 48),
          const Expanded(
            child: Center(
              child: SizedBox(
                width: 40,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFBDBDBD),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: onDelete != null
                ? IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: Colors.red.shade300, size: 22),
                    tooltip: '删除',
                    onPressed: onDelete,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
