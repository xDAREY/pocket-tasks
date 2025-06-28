# Pocket Tasks

A user-friendly task management app built with Flutter and Riverpod, designed for clean architecture and seamless offline support.

---

## 🚀 Features

* **CRUD Tasks**: Add, edit, delete, and toggle completion
* **Filtering**: View All, Active, or Completed tasks
* **Sorting**: By Due Date or Creation Date
* **Theming**: Responsive Light & Dark modes
* **Offline First**: Local storage via Hive with offline access
* **Clean UI**: Material Design 3, rounded cards, subtle shadows

---

## 🎨 UI / Screens

1. **Task List**

   * Filter chips (All / Active / Completed)
   * Sort dropdown menu
   * Swipe tasks to delete or mark complete
   * Floating Action Button to add new tasks

2. **Add / Edit Task**

   * **Form Fields**: Title (required), Notes (optional)
   * **Date Picker**: Select or clear due date
   * **Completion Toggle** (in edit mode)
   * Save button in AppBar for quick access

3. **Task Details** *(optional)*

   * Full task info: title, notes, created/updated timestamps, due date, status
   * Actions: Edit or Delete

---

## 🛠️ Functionality Overview

### Add / Edit Task Screen

```dart
class AddEditTaskScreen extends ConsumerStatefulWidget { ... }
```

* Uses a **Form** with validation on the title
* Initializes fields when editing an existing task
* `_selectDate()` invokes `showDatePicker` for due date selection
* `_saveTask()` reads form state and calls:

  ```dart
  if (isEditing) {
    ref.read(taskListProvider.notifier).updateTask(task);
  } else {
    ref.read(taskListProvider.notifier).addTask(task);
  }
  ```

### Task Details Screen

```dart
class TaskDetailsScreen extends ConsumerWidget { ... }
```

* Displays a **Card** with checkbox + title, strikes through completed tasks
* Shows notes and task metadata in styled rows
* Provides Edit and Delete icons in AppBar
* `_showDeleteDialog()` confirms before removal:

  ```dart
  ref.read(taskListProvider.notifier).deleteTask(task.id);
  ```

---

## 📦 State Management & Code Snippets

* **Providers**:

  ```dart
  final taskListProvider = StateNotifierProvider<TaskNotifier, List<Task>>(...);
  final taskFilterProvider = StateProvider<TaskFilter>((_) => TaskFilter.all);
  final taskSortProvider   = StateProvider<TaskSort>((_) => TaskSort.createdDate);
  ```
* **Filtering & Sorting** combined in `filteredTasksProvider`:

  ```dart
  final filteredTasksProvider = Provider<List<Task>>((ref) {
    final tasks = ref.watch(taskListProvider);
    // apply filter, then sort...
  });
  ```

---

## 🏛️ Architecture

```
lib/
├── models/      # Task model, -g.
├── providers/   # TaskProvider & ThemeProvider
├── screens/     # HomeScreen, AddEditTask, TaskDetails
├── services/    # Hive storage service
├── widgets/     # TaskItem, FilterOptions, SortDropdown etc
└── utils/       # ThemeData
```

Key decisions:

1. **Riverpod** for modular, testable state logic
2. **Hive** for performant JSON-like storage


---

## Snapshot
# light mode:
![Screenshot_1751136503](https://github.com/user-attachments/assets/620ed2bb-4a2d-48bc-ad8a-43f2045b57b1)

![Screenshot_1751136497](https://github.com/user-attachments/assets/d13dd43e-c230-464e-8cd8-dd7927e14267)

## dark mode:
![Screenshot_1751136518](https://github.com/user-attachments/assets/fdea71b5-d1e3-4e48-b05c-ea1a2d2b30a7)

![Screenshot_1751136513](https://github.com/user-attachments/assets/6d3d51ab-90cb-4b09-bf1a-8b565dc0846d)



---


## 📦 Build & Release

```bash
# Install deps
git clone ... && cd pocket_tasks
flutter pub get
# Codegen
flutter pub run build_runner build
# Debuglutter run
# Release APK
flutter build apk --split-per-abi
```

APK artifacts: `build/app/outputs/flutter-apk/`

---

## 🤝 Contributing

1. Fork the repo
2. Create a branch: `git checkout -b feat/your-feature`
3. Commit with semantic messages
4. Push and open a PR

---

## 🏷️ Commit Message Examples

```bash
feat: add TaskFilter and TaskSort 
feat: implement  Hive storage
docs: update README with functionality overview
```

---

## 📄 License

Licensed under MIT. See [LICENSE](LICENSE) for details.
