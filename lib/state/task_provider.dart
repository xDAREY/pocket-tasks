import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/models/task_model.dart';
import '../services/storage_service.dart';

enum TaskFilter { all, active, completed }
enum TaskSort { dueDate, createdDate }

final taskListProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
final taskSortProvider = StateProvider<TaskSort>((ref) => TaskSort.createdDate);

final filteredTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskListProvider);
  final filter = ref.watch(taskFilterProvider);
  final sort = ref.watch(taskSortProvider);

  List<Task> filteredTasks;

  switch (filter) {
    case TaskFilter.active:
      filteredTasks = tasks.where((task) => !task.isCompleted).toList();
      break;
    case TaskFilter.completed:
      filteredTasks = tasks.where((task) => task.isCompleted).toList();
      break;
    case TaskFilter.all:
    filteredTasks = tasks;
  }

  switch (sort) {
    case TaskSort.dueDate:
      filteredTasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
      break;
    case TaskSort.createdDate:
    filteredTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  return filteredTasks;
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    state = StorageService.getAllTasks();
  }

  Future<void> addTask(Task task) async {
    await StorageService.addTask(task);
    state = [...state, task];
  }

  Future<void> updateTask(Task updatedTask) async {
    await StorageService.updateTask(updatedTask);
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }

  Future<void> deleteTask(String id) async {
    await StorageService.deleteTask(id);
    state = state.where((task) => task.id != id).toList();
  }

  Future<void> toggleTask(String id) async {
    final task = state.firstWhere((t) => t.id == id);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }
}