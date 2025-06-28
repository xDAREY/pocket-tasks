import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart'; 

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  DateTime? dueDate;

  @HiveField(4)
  DateTime? dueTime; 

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  TaskPriority priority;

  @HiveField(9)
  String category;

  Task({
    String? id,
    required this.title,
    this.note = '',
    this.dueDate,
    this.dueTime,
    this.isCompleted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.priority = TaskPriority.medium,
    this.category = 'general',
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Task copyWith({
    String? title,
    String? note,
    DateTime? dueDate,
    DateTime? dueTime,
    bool? isCompleted,
    TaskPriority? priority,
    String? category,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      note: note ?? this.note,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      priority: priority ?? this.priority,
      category: category ?? this.category,
    );
  }

  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    final now = DateTime.now();
    if (dueTime != null) {
      final fullDueDateTime = DateTime(
        dueDate!.year,
        dueDate!.month,
        dueDate!.day,
        dueTime!.hour,
        dueTime!.minute,
      );
      return now.isAfter(fullDueDateTime);
    }
    return now.isAfter(dueDate!.add(const Duration(hours: 23, minutes: 59)));
  }

  bool get isToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    return dueDate!.year == now.year &&
           dueDate!.month == now.month &&
           dueDate!.day == now.day;
  }

  bool get isTomorrow {
    if (dueDate == null) return false;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dueDate!.year == tomorrow.year &&
           dueDate!.month == tomorrow.month &&
           dueDate!.day == tomorrow.day;
  }

  String get timeString {
    if (dueTime == null) return '';
    final hour = dueTime!.hour;
    final minute = dueTime!.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString()}:${minute.toString().padLeft(2, '0')} $period';
  }
}

@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
  @HiveField(3)
  urgent,
}