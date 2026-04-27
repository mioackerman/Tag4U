import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/presentation/providers/person_providers.dart';
import 'package:tag4u/presentation/widgets/person_card.dart';
import 'package:tag4u/presentation/widgets/person_detail_sheet.dart';
import 'package:uuid/uuid.dart';

class PersonsPage extends ConsumerWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('人物'),
        centerTitle: false,
      ),
      body: personsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('错误：$e')),
        data: (persons) => persons.isEmpty
            ? _EmptyState(onAdd: () => _showAddDialog(context, ref))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemCount: persons.length,
                itemBuilder: (context, i) => PersonCard(
                  person: persons[i],
                  onTap: () => _showDetail(context, persons[i].id),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        tooltip: '添加人物',
        child: const Icon(Icons.person_add_outlined),
      ),
    );
  }

  void _showDetail(BuildContext context, String personId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => PersonDetailSheet(personId: personId),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('添加人物'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: '名字',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) => _submit(ctx, ref, controller),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => _submit(ctx, ref, controller),
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }

  void _submit(
    BuildContext ctx,
    WidgetRef ref,
    TextEditingController controller,
  ) {
    final name = controller.text.trim();
    if (name.isEmpty) return;
    final now = DateTime.now();
    ref.read(personsProvider.notifier).upsert(
          PersonNode(
            id: const Uuid().v4(),
            name: name,
            createdAt: now,
            updatedAt: now,
          ),
        );
    Navigator.pop(ctx);
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.people_outline, size: 72, color: Colors.grey),
          const SizedBox(height: 16),
          Text('还没有人物',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            '点击右下角 + 开始添加',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: onAdd,
            child: const Text('添加第一个人物'),
          ),
        ],
      ),
    );
  }
}
