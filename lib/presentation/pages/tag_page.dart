import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/tag_category.dart';
import 'package:tag4u/presentation/pages/tag_category_detail_page.dart';
import 'package:tag4u/presentation/providers/tag_category_providers.dart';

class TagPage extends ConsumerWidget {
  const TagPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(tagCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemCount: categories.length + 1,
          itemBuilder: (context, i) {
            if (i == categories.length) {
              return _AddCategoryCard(
                onAdd: (name) =>
                    ref.read(tagCategoriesProvider.notifier).addCustom(name),
              );
            }
            final cat = categories[i];
            return _CategoryCard(
              category: cat,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TagCategoryDetailPage(category: cat),
                ),
              ),
              onLongPress: cat.type == TagCategoryType.custom
                  ? () => _confirmDelete(context, ref, cat)
                  : null,
            );
          },
        ),
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, WidgetRef ref, TagCategory cat) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除分类'),
        content: Text('确认删除"${cat.name}"？'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(tagCategoriesProvider.notifier).remove(cat.id);
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final TagCategory category;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const _CategoryCard({
    required this.category,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: category.color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: category.color.withOpacity(0.35), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(category.icon, size: 38, color: category.color),
              const SizedBox(height: 10),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: category.color.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Add-category card ─────────────────────────────────────────────────────────

class _AddCategoryCard extends StatelessWidget {
  final ValueChanged<String> onAdd;
  const _AddCategoryCard({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => _showAddDialog(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 38, color: Colors.grey.shade400),
              const SizedBox(height: 10),
              Text(
                '添加分类',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加分类'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '分类名称'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              Navigator.pop(ctx);
              if (name.isNotEmpty) onAdd(name);
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }
}
