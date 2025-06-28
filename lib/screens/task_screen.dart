// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pocket_tasks/screens/settings_screen.dart';
// import 'package:pocket_tasks/state/task_provider.dart';
// import 'package:pocket_tasks/widgets/task_selection.dart';
// import '../widgets/filter_chips.dart';
// import '../widgets/sort_dropdown.dart';
// import 'add_edit_task_screen.dart';


// class TasksScreen extends ConsumerWidget {
//   const TasksScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final groupedTasks = ref.watch(groupedTasksProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Tasks'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings_outlined),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SettingScreen()),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Filter chips
//           const FilterChips(),
          
//           // Sort dropdown
//           const SortDropdown(),
          
//           // Tasks list
//           Expanded(
//             child: groupedTasks.isEmpty
//                 ? _buildEmptyState(context)
//                 : ListView.separated(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     itemCount: groupedTasks.length,
//                     separatorBuilder: (context, index) => const SizedBox(height: 24),
//                     itemBuilder: (context, index) {
//                       final entry = groupedTasks.entries.elementAt(index);
//                       return TaskSection(
//                         title: entry.key,
//                         tasks: entry.value,
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
//         ),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.task_alt,
//             size: 80,
//             color: Theme.of(context).colorScheme.outline,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No tasks yet',
//             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//               color: Theme.of(context).colorScheme.outline,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Tap + to add your first task',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: Theme.of(context).colorScheme.outline,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }