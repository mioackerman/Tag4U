import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/presentation/providers/recommendation_providers.dart';

/// Minimal home screen — intentionally skeleton only.
/// Real UI implementation follows after the system foundation is stable.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(recentPlansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag4U'),
        centerTitle: false,
      ),
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plans) => plans.isEmpty
            ? const _EmptyState()
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: plans.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final plan = plans[i];
                  return ListTile(
                    title: Text(plan.title),
                    subtitle: Text(
                      '${plan.items.length} places · '
                      '${plan.createdAt.toLocal().toString().substring(0, 16)}',
                    ),
                    trailing: plan.overallScore != null
                        ? Text(
                            plan.overallScore!.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        : null,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to GroupPlanningFlow
        },
        icon: const Icon(Icons.map_outlined),
        label: const Text('Plan now'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.explore_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No plans yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap "Plan now" to create your first group plan.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
