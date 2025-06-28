import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/state/task_provider.dart';

class FilterOptions extends ConsumerWidget {
  const FilterOptions({super.key});

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
          _buildFilterOptions(
            context,
            ref,
            'All (${tasks.length})',
            TaskFilter.all,
            currentFilter == TaskFilter.all,
          ),
          const SizedBox(width: 8),
          _buildFilterOptions(
            context,
            ref,
            'Active ($activeTasks)',
            TaskFilter.active,
            currentFilter == TaskFilter.active,
          ),
          const SizedBox(width: 8),
          _buildFilterOptions(
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

  Widget _buildFilterOptions(
    BuildContext context,
    WidgetRef ref,
    String label,
    TaskFilter filter,
    bool isSelected,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected 
            ? (isDarkMode ? Colors.black : Colors.white) 
            : (isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      selected: isSelected,
      selectedColor: isDarkMode 
        ? const Color(0xFFF5E6D3)  
        : const Color(0xFF8B4513),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDarkMode 
            ? const Color(0xFFF5E6D3).withValues(alpha: 0.3)
            : const Color(0xFF8B4513).withValues(alpha: 0.3),
        ),
      ),
      onSelected: (_) => ref.read(taskFilterProvider.notifier).state = filter,
    );
  }
}