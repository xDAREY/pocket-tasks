import 'package:flutter/material.dart';
import 'package:pocket_tasks/models/task_model.dart';
import 'task_item.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<Task> tasks;

  const TaskSection({
    super.key,
    required this.title,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        ...tasks.map((task) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TaskItem(task: task),
        )),
      ],
    );
  }
}