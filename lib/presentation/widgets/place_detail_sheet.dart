import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/place_node.dart';
import 'package:tag4u/domain/entities/semantic_descriptor.dart';
import 'package:tag4u/presentation/providers/place_providers.dart';
import 'package:tag4u/presentation/widgets/entity_detail_sheet.dart';
import 'package:tag4u/presentation/widgets/place_card.dart';
import 'package:uuid/uuid.dart';

/// Detail bottom sheet for a [PlaceNode].
///
/// Uses [EntityDetailSheet] as the layout shell and injects:
///   - [EntityNameHeader]     — inline-editable name with category avatar
///   - [_PlaceBasicInfoSection] — category / address / note / price chips
///   - [DetailSection] for user-defined descriptor tags
///   - [EntityAddTagSection]  — simple add-tag input (no sentiment)
class PlaceDetailSheet extends ConsumerStatefulWidget {
  final String placeId;
  const PlaceDetailSheet({super.key, required this.placeId});

  @override
  ConsumerState<PlaceDetailSheet> createState() => _PlaceDetailSheetState();
}

class _PlaceDetailSheetState extends ConsumerState<PlaceDetailSheet> {
  final _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final place = ref.watch(placeByIdProvider(widget.placeId));
    final descriptorsAsync =
        ref.watch(placeDescriptorsProvider(widget.placeId));

    if (place == null) return const SizedBox.shrink();

    return EntityDetailSheet(
      onDelete: () =>
          ref.read(placesProvider.notifier).delete(widget.placeId),
      header: EntityNameHeader(
        avatar: CircleAvatar(
          radius: 24,
          backgroundColor: placeCategoryColor(place.category),
          child: Icon(
            placeCategoryIcon(place.category),
            color: Colors.white,
            size: 20,
          ),
        ),
        name: place.name,
        onSave: (name) => ref.read(placesProvider.notifier).upsert(
              place.copyWith(name: name, updatedAt: DateTime.now()),
            ),
      ),
      sections: [
        _PlaceBasicInfoSection(place: place),
        DetailSection(
          title: '自定义标签',
          child: descriptorsAsync.when(
            loading: () => const SizedBox(
                height: 32,
                child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2))),
            error: (e, _) =>
                Text('$e', style: const TextStyle(color: Colors.red)),
            data: (descriptors) {
              final userTags = descriptors
                  .where((d) => d.source == DescriptorSource.userDefined)
                  .toList();
              if (userTags.isEmpty) {
                return Text('还没有标签',
                    style: TextStyle(color: Colors.grey.shade400));
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: userTags
                    .map((d) => _PlaceTagChip(
                          descriptor: d,
                          onDelete: () => ref
                              .read(placeDescriptorsProvider(widget.placeId)
                                  .notifier)
                              .removeDescriptor(d.id),
                        ))
                    .toList(),
              );
            },
          ),
        ),
        EntityAddTagSection(
          controller: _tagController,
          hint: '例：环境安静、适合聚会、停车方便',
          onSubmit: _submitTag,
        ),
      ],
    );
  }

  void _submitTag() {
    final label = _tagController.text.trim();
    if (label.isEmpty) return;
    ref
        .read(placeDescriptorsProvider(widget.placeId).notifier)
        .addDescriptor(
          SemanticDescriptor(
            id: const Uuid().v4(),
            placeNodeId: widget.placeId,
            descriptor: label,
            source: DescriptorSource.userDefined,
            createdAt: DateTime.now(),
          ),
        );
    _tagController.clear();
  }
}

// ── Place-specific sections ───────────────────────────────────────────────────

/// Basic-info chips: category, address, personal note, price level.
class _PlaceBasicInfoSection extends ConsumerWidget {
  final PlaceNode place;
  const _PlaceBasicInfoSection({required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DetailSection(
      title: '基本信息',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          DetailInfoChip(
            icon: placeCategoryIcon(place.category),
            label: placeCategoryLabel(place.category),
            onTap: () => _editCategory(context, ref),
          ),
          DetailInfoChip(
            icon: Icons.location_on_outlined,
            label:
                place.address?.isNotEmpty == true ? place.address! : '地址未填',
            onTap: () => showEditTextDialog(
              context,
              title: '地址',
              hint: '例：北京市朝阳区xxx路',
              current: place.address,
              onSave: (v) => ref.read(placesProvider.notifier).upsert(
                    place.copyWith(
                        address: v.isEmpty ? null : v,
                        updatedAt: DateTime.now()),
                  ),
            ),
          ),
          DetailInfoChip(
            icon: Icons.sticky_note_2_outlined,
            label: place.personalNote?.isNotEmpty == true
                ? place.personalNote!
                : '备注未填',
            onTap: () => showEditTextDialog(
              context,
              title: '个人备注',
              hint: '例：环境不错，适合约会',
              current: place.personalNote,
              onSave: (v) => ref.read(placesProvider.notifier).upsert(
                    place.copyWith(
                        personalNote: v.isEmpty ? null : v,
                        updatedAt: DateTime.now()),
                  ),
            ),
          ),
          DetailInfoChip(
            icon: Icons.attach_money_outlined,
            label: place.priceLevel != null
                ? '￥' * place.priceLevel!
                : '价位未填',
            onTap: () => _editPriceLevel(context, ref),
          ),
        ],
      ),
    );
  }

  void _editCategory(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('选择分类'),
        children: PlaceCategory.values.map((cat) {
          final selected = cat == place.category;
          return SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              if (selected) return;
              ref.read(placesProvider.notifier).upsert(
                    place.copyWith(
                        category: cat, updatedAt: DateTime.now()),
                  );
            },
            child: Row(
              children: [
                Icon(placeCategoryIcon(cat),
                    size: 20,
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : null),
                const SizedBox(width: 12),
                Text(
                  placeCategoryLabel(cat),
                  style: selected
                      ? TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600)
                      : null,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _editPriceLevel(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('价位'),
        children: [
          for (int i = 1; i <= 4; i++)
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx);
                ref.read(placesProvider.notifier).upsert(
                      place.copyWith(
                          priceLevel: i, updatedAt: DateTime.now()),
                    );
              },
              child: Text(
                '￥' * i,
                style: place.priceLevel == i
                    ? TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600)
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Place-specific tag chip ───────────────────────────────────────────────────

class _PlaceTagChip extends StatelessWidget {
  final SemanticDescriptor descriptor;
  final VoidCallback onDelete;

  const _PlaceTagChip(
      {required this.descriptor, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(descriptor.descriptor),
      backgroundColor: Theme.of(context)
          .colorScheme
          .secondaryContainer
          .withValues(alpha: 0.6),
      deleteIcon: const Icon(Icons.close, size: 15),
      onDeleted: onDelete,
    );
  }
}
