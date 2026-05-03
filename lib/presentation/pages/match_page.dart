import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/fused_tag.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/presentation/providers/fusion_providers.dart';
import 'package:tag4u/presentation/providers/match_providers.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/place_card.dart';

class MatchPage extends ConsumerWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(matchSelectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('匹配'),
        centerTitle: false,
        actions: [
          if (!selection.isEmpty)
            TextButton(
              onPressed: () {
                ref.read(matchSelectionProvider.notifier).clear();
                ref.read(aiMatchProvider.notifier).clearResults();
              },
              child: const Text('清除'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _ParticipantsBlock(),
                SizedBox(height: 12),
                _CategoryBlock(),
                SizedBox(height: 12),
                _PlaceTagsBlock(),
                SizedBox(height: 12),
                _CuisineTagsBlock(),
                SizedBox(height: 8),
              ],
            ),
          ),
          const _AiChatPanel(),
          const _MatchResultsPanel(),
        ],
      ),
    );
  }
}

// ── Place characteristic tags block ──────────────────────────────────────────

class _PlaceTagsBlock extends ConsumerWidget {
  const _PlaceTagsBlock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fusedAsync = ref.watch(fusedPlaceTagsProvider);
    final selection = ref.watch(matchSelectionProvider);

    return _SectionCard(
      title: '地点特征',
      icon: Icons.location_on_outlined,
      child: fusedAsync.when(
        loading: () => const _LoadingChips(),
        error: (e, _) => Text('加载失败：$e'),
        data: (fusedTags) => fusedTags.isEmpty
            ? const _EmptyHint(text: '暂无地点标签 — 前往地点页面添加标签')
            : _FusedChipWrap(
                fusedTags: fusedTags,
                selected: selection.selectedPlaceTags,
                onTap: (label) => ref
                    .read(matchSelectionProvider.notifier)
                    .togglePlaceTag(label),
              ),
      ),
    );
  }
}

// ── Cuisine tags block ────────────────────────────────────────────────────────

class _CuisineTagsBlock extends ConsumerWidget {
  const _CuisineTagsBlock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fusedAsync = ref.watch(fusedCuisineTagsProvider);
    final selection = ref.watch(matchSelectionProvider);

    return _SectionCard(
      title: '菜式 / 口味',
      icon: Icons.restaurant_menu_outlined,
      child: fusedAsync.when(
        loading: () => const _LoadingChips(),
        error: (e, _) => Text('加载失败：$e'),
        data: (fusedTags) => fusedTags.isEmpty
            ? const _EmptyHint(text: '暂无菜式标签 — 前往餐厅页面添加标签')
            : _FusedChipWrap(
                fusedTags: fusedTags,
                selected: selection.selectedCuisineTags,
                onTap: (label) => ref
                    .read(matchSelectionProvider.notifier)
                    .toggleCuisineTag(label),
              ),
      ),
    );
  }
}

// ── Activity category block ───────────────────────────────────────────────────

class _CategoryBlock extends ConsumerWidget {
  const _CategoryBlock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(savedCategoriesProvider);
    final selection = ref.watch(matchSelectionProvider);

    return _SectionCard(
      title: '活动类型',
      icon: Icons.category_outlined,
      child: categories.isEmpty
          ? const _EmptyHint(text: '暂无已保存的地点')
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((cat) {
                final selected =
                    selection.selectedCategories.contains(cat);
                final color = placeCategoryColor(cat);
                return _SelectableChip(
                  label: placeCategoryLabel(cat),
                  selected: selected,
                  selectedColor: color,
                  icon: placeCategoryIcon(cat),
                  onTap: () => ref
                      .read(matchSelectionProvider.notifier)
                      .toggleCategory(cat),
                );
              }).toList(),
            ),
    );
  }
}

// ── Participants block ────────────────────────────────────────────────────────

class _ParticipantsBlock extends ConsumerWidget {
  const _ParticipantsBlock();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);
    final selection = ref.watch(matchSelectionProvider);
    final selectedIds = selection.selectedPersons.map((p) => p.id).toSet();

    return _SectionCard(
      title: '参与人',
      icon: Icons.people_outline,
      child: personsAsync.when(
        loading: () => const _LoadingChips(),
        error: (e, _) => Text('加载失败：$e'),
        data: (persons) => persons.isEmpty
            ? const _EmptyHint(text: '暂无已保存人物 — 前往好友页面添加')
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: persons.map((person) {
                  final selected = selectedIds.contains(person.id);
                  return _PersonChip(
                    person: person,
                    selected: selected,
                    onTap: () => ref
                        .read(matchSelectionProvider.notifier)
                        .togglePerson(person),
                  );
                }).toList(),
              ),
      ),
    );
  }
}

// ── AI Chat Panel ─────────────────────────────────────────────────────────────

class _AiChatPanel extends ConsumerStatefulWidget {
  const _AiChatPanel();

  @override
  ConsumerState<_AiChatPanel> createState() => _AiChatPanelState();
}

class _AiChatPanelState extends ConsumerState<_AiChatPanel> {
  bool _expanded = false;
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _recommend() {
    final text = _inputController.text.trim();
    ref.read(aiMatchProvider.notifier).recommend(text);
    _inputController.clear();
    // Scroll chat to bottom after messages update.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(aiMatchProvider);
    final personsAsync = ref.watch(personsProvider);
    final selectedIds =
        aiState.participants.map((p) => p.id).toSet();
    final primary = Theme.of(context).colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      constraints: BoxConstraints(maxHeight: _expanded ? 320 : 56),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Collapsed strip / header ──────────────────────────────────
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: SizedBox(
              height: 56,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome,
                        size: 16, color: primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _expanded ? 'AI 推荐' : '今天想做什么…',
                        style: TextStyle(
                          color: _expanded
                              ? primary
                              : Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (aiState.isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2),
                      )
                    else if (aiState.hasResults)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'AI 结果',
                          style: TextStyle(
                              fontSize: 11,
                              color: primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    const SizedBox(width: 4),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_expanded) ...[
            const Divider(height: 1),

            // ── Participant chips ─────────────────────────────────────
            personsAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (persons) => persons.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        children: persons.map((p) {
                          final sel = selectedIds.contains(p.id);
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 6),
                            child: FilterChip(
                              label: Text(p.name,
                                  style:
                                      const TextStyle(fontSize: 12)),
                              selected: sel,
                              onSelected: (_) => ref
                                  .read(aiMatchProvider.notifier)
                                  .toggleParticipant(p),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),

            // ── Chat messages ─────────────────────────────────────────
            if (aiState.messages.isNotEmpty)
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  itemCount: aiState.messages.length,
                  itemBuilder: (_, i) {
                    final msg = aiState.messages[i];
                    final isUser = msg.role == 'user';
                    return Align(
                      alignment: isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isUser
                              ? primary.withValues(alpha: 0.15)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width *
                                    0.75),
                        child: Text(msg.text,
                            style: const TextStyle(fontSize: 13)),
                      ),
                    );
                  },
                ),
              ),

            if (aiState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(aiState.error!,
                    style: TextStyle(
                        color: Colors.red.shade400, fontSize: 12)),
              ),

            // ── Input + recommend button ──────────────────────────────
            SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(12, 6, 12, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        decoration: InputDecoration(
                          hintText: '今天想做什么…',
                          hintStyle:
                              const TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surface,
                          contentPadding:
                              const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                          isDense: true,
                        ),
                        onSubmitted: (_) => aiState.isLoading
                            ? null
                            : _recommend(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed:
                          aiState.isLoading ? null : _recommend,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(60, 36),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20)),
                      ),
                      child: const Text('推荐',
                          style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Results panel (pinned at bottom) ─────────────────────────────────────────

class _MatchResultsPanel extends ConsumerWidget {
  const _MatchResultsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(matchSelectionProvider);
    final aiState = ref.watch(aiMatchProvider);

    // Use AI results if available, fall back to local match results.
    final bool showAi = aiState.hasResults;

    return Container(
      constraints: const BoxConstraints(maxHeight: 320),
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.auto_awesome,
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.9)),
                const SizedBox(width: 6),
                Text(
                  showAi ? 'AI 推荐结果' : 'Best Matched',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (showAi) ...[
                  const Spacer(),
                  GestureDetector(
                    onTap: () =>
                        ref.read(aiMatchProvider.notifier).clearResults(),
                    child: Text(
                      '切换本地结果',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(
              height: 1,
              color: Colors.white24,
              indent: 20,
              endIndent: 20),
          if (showAi)
            _AiResultsList(results: aiState.results!)
          else
            _LocalResultsView(selection: selection),
          SizedBox(
              height: MediaQuery.paddingOf(context).bottom > 0
                  ? MediaQuery.paddingOf(context).bottom
                  : 8),
        ],
      ),
    );
  }
}

// ── AI results list ───────────────────────────────────────────────────────────

class _AiResultsList extends StatelessWidget {
  final List<AiPlaceResult> results;
  const _AiResultsList({required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'AI 没有找到合适的地点',
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13),
        ),
      );
    }
    return Flexible(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(
            height: 1, color: Colors.white24, indent: 48),
        itemBuilder: (_, i) {
          final r = results[i];
          final color = placeCategoryColor(r.place.category);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${r.rank}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                      placeCategoryIcon(r.place.category),
                      size: 16,
                      color: Colors.white),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.place.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (r.reason.isNotEmpty)
                        Text(
                          r.reason,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.65),
                            fontSize: 11,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Local match results ───────────────────────────────────────────────────────

class _LocalResultsView extends ConsumerWidget {
  final MatchSelectionState selection;
  const _LocalResultsView({required this.selection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(matchResultsProvider);

    if (selection.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          '选择上方标签或参与人，实时显示最匹配地点',
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13),
        ),
      );
    }

    return resultsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2)),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(20),
        child: Text('出错了：$e',
            style: const TextStyle(color: Colors.white70)),
      ),
      data: (results) => results.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '没有找到匹配的地点',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13),
              ),
            )
          : Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: results.length,
                separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: Colors.white24,
                    indent: 48),
                itemBuilder: (_, i) =>
                    _ResultTile(rank: i + 1, result: results[i]),
              ),
            ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final int rank;
  final MatchResult result;

  const _ResultTile({required this.rank, required this.result});

  @override
  Widget build(BuildContext context) {
    final place = result.place;
    final color = placeCategoryColor(place.category);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(placeCategoryIcon(place.category),
                size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (result.matchedTags.isNotEmpty)
                  Text(
                    result.matchedTags.join(' · '),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              result.score.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared card shell ─────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: Colors.blue.shade600),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ── Fused chip row ────────────────────────────────────────────────────────────

class _FusedChipWrap extends StatelessWidget {
  final List<FusedTag> fusedTags;
  final Set<String> selected;
  final void Function(String) onTap;

  const _FusedChipWrap({
    required this.fusedTags,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: fusedTags
          .map((f) => _SelectableChip(
                label: f.displayLabel,
                selected: selected.contains(f.displayLabel),
                isMerged: f.isMerged,
                onTap: () => onTap(f.displayLabel),
              ))
          .toList(),
    );
  }
}

// ── Person chip ───────────────────────────────────────────────────────────────

class _PersonChip extends StatelessWidget {
  final PersonNode person;
  final bool selected;
  final VoidCallback onTap;

  const _PersonChip({
    required this.person,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue.shade600;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? color.withValues(alpha: 0.6)
                : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 9,
              backgroundColor: selected
                  ? color.withValues(alpha: 0.3)
                  : Colors.grey.shade200,
              child: Text(
                person.name.isNotEmpty
                    ? person.name.characters.first
                    : '?',
                style: TextStyle(
                    fontSize: 10,
                    color: selected ? color : Colors.grey.shade600,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              person.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? color : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Selectable chip ───────────────────────────────────────────────────────────

class _SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final IconData? icon;
  final bool isMerged;

  const _SelectableChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.icon,
    this.isMerged = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = selectedColor ?? Colors.blue.shade600;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? activeColor.withValues(alpha: 0.14)
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? activeColor.withValues(alpha: 0.55)
                : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 14,
                  color: selected ? activeColor : Colors.grey.shade600),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? activeColor : Colors.grey.shade700,
              ),
            ),
            if (isMerged) ...[
              const SizedBox(width: 4),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? activeColor.withValues(alpha: 0.7)
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Minor helpers ─────────────────────────────────────────────────────────────

class _LoadingChips extends StatelessWidget {
  const _LoadingChips();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
          child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2))),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final String text;
  const _EmptyHint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text,
          style:
              TextStyle(fontSize: 13, color: Colors.grey.shade500)),
    );
  }
}
