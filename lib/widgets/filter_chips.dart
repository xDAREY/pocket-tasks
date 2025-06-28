import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/state/task_provider.dart';

class TaskFilterChips extends ConsumerWidget {
  const TaskFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(taskFilterProvider);
    final tasks = ref.watch(taskListProvider);

    final activeTasks = tasks.where((task) => !task.isCompleted).length;
    final completedTasks = tasks.where((task) => task.isCompleted).length;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildFilterChip(
            context,
            ref,
            'All (${tasks.length})',
            TaskFilter.all,
            currentFilter == TaskFilter.all,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            ref,
            'Active ($activeTasks)',
            TaskFilter.active,
            currentFilter == TaskFilter.active,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            ref,
            'Completed ($completedTasks)',
            TaskFilter.completed,
            currentFilter == TaskFilter.completed,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    TaskFilter filter,
    bool isSelected,
  ) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => ref.read(taskFilterProvider.notifier).state = filter,
    );
  }
}