import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/state/task_provider.dart';

class SortDropdown extends ConsumerWidget {
  const SortDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(taskSortProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Text(
            'Sort by:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<TaskSort>(
            value: currentSort,
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.primary,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            items: const [
              DropdownMenuItem(
                value: TaskSort.dueDate,
                child: Text('Due Date'),
              ),
              DropdownMenuItem(
                value: TaskSort.createdDate,
                child: Text('Created Date'),
              ),
            ],
            onChanged: (sort) {
              if (sort != null) {
                ref.read(taskSortProvider.notifier).state = sort;
              }
            },
          ),
        ],
      ),
    );
  }
}