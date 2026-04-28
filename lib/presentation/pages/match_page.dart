import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
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
              onPressed: () =>
                  ref.read(matchSelectionProvider.notifier).clear(),
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
                _PlaceTagsBlock(),
                SizedBox(height: 12),
                _CuisineTagsBlock(),
                SizedBox(height: 12),
                _CategoryBlock(),
                SizedBox(height: 12),
                _ParticipantsBlock(),
                SizedBox(height: 8),
              ],
            ),
          ),
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
    final tagsAsync = ref.watch(placeCharacteristicTagsProvider);
    final selection = ref.watch(matchSelectionProvider);

    return _SectionCard(
      title: '地点特征',
      icon: Icons.location_on_outlined,
      child: tagsAsync.when(
        loading: () => const _LoadingChips(),
        error: (e, _) => Text('加载失败：$e'),
        data: (tags) => tags.isEmpty
            ? const _EmptyHint(text: '暂无地点标签 — 前往地点页面添加标签')
            : _ChipWrap(
                tags: tags,
                selected: selection.selectedPlaceTags,
                onTap: (t) =>
                    ref.read(matchSelectionProvider.notifier).togglePlaceTag(t),
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
    final tagsAsync = ref.watch(cuisineTagsProvider);
    final selection = ref.watch(matchSelectionProvider);

    return _SectionCard(
      title: '菜式 / 口味',
      icon: Icons.restaurant_menu_outlined,
      child: tagsAsync.when(
        loading: () => const _LoadingChips(),
        error: (e, _) => Text('加载失败：$e'),
        data: (tags) => tags.isEmpty
            ? const _EmptyHint(text: '暂无菜式标签 — 前往餐厅页面添加标签')
            : _ChipWrap(
                tags: tags,
                selected: selection.selectedCuisineTags,
                onTap: (t) => ref
                    .read(matchSelectionProvider.notifier)
                    .toggleCuisineTag(t),
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
                final selected = selection.selectedCategories.contains(cat);
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
            ? const _EmptyHint(text: '暂无已保存人物 — 前往 Tag 页面添加')
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

// ── Results panel (pinned at bottom) ─────────────────────────────────────────

class _MatchResultsPanel extends ConsumerWidget {
  const _MatchResultsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(matchSelectionProvider);
    final resultsAsync = ref.watch(matchResultsProvider);

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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.auto_awesome,
                    size: 16, color: Colors.white.withValues(alpha: 0.9)),
                const SizedBox(width: 6),
                Text(
                  'Best Matched',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
              height: 1, color: Colors.white24, indent: 20, endIndent: 20),
          if (selection.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '选择上方标签或参与人，实时显示最匹配地点',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7), fontSize: 13),
              ),
            )
          else
            resultsAsync.when(
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
                            height: 1, color: Colors.white24, indent: 48),
                        itemBuilder: (_, i) =>
                            _ResultTile(rank: i + 1, result: results[i]),
                      ),
                    ),
            ),
          SizedBox(
              height: MediaQuery.paddingOf(context).bottom > 0
                  ? MediaQuery.paddingOf(context).bottom
                  : 8),
        ],
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

// ── Chip row widget ───────────────────────────────────────────────────────────

class _ChipWrap extends StatelessWidget {
  final List<String> tags;
  final Set<String> selected;
  final void Function(String) onTap;

  const _ChipWrap({
    required this.tags,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map((t) => _SelectableChip(
                label: t,
                selected: selected.contains(t),
                onTap: () => onTap(t),
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
            color:
                selected ? color.withValues(alpha: 0.6) : Colors.grey.shade300,
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
                person.name.isNotEmpty ? person.name.characters.first : '?',
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
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
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

  const _SelectableChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor,
    this.icon,
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
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                color: selected ? activeColor : Colors.grey.shade700,
              ),
            ),
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
          style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
    );
  }
}
