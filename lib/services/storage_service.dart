import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_tasks/models/task_model.dart';

class StorageService {
  static const String _taskBoxName = 'tasks';
  static Box<Task>? _taskBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register both adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    
    // Register the TaskPriority adapter
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskPriorityAdapter());
    }
    
    _taskBox = await Hive.openBox<Task>(_taskBoxName);
  }

  static Box<Task> get taskBox {
    if (_taskBox == null || !_taskBox!.isOpen) {
      throw Exception('Task box not initialized');
    }
    return _taskBox!;
  }

  static Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  static Future<void> updateTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  static Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  static List<Task> getAllTasks() {
    return taskBox.values.toList();
  }

  static Task? getTask(String id) {
    return taskBox.get(id);
  }

  // Additional helper methods
  static List<Task> getCompletedTasks() {
    return taskBox.values.where((task) => task.isCompleted).toList();
  }

  static List<Task> getPendingTasks() {
    return taskBox.values.where((task) => !task.isCompleted).toList();
  }

  static List<Task> getTasksByPriority(TaskPriority priority) {
    return taskBox.values.where((task) => task.priority == priority).toList();
  }

  static Future<void> clearAllTasks() async {
    await taskBox.clear();
  }

  static Future<void> dispose() async {
    await _taskBox?.close();
    _taskBox = null;
  }
}