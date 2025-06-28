import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/screens/homescreen.dart';
import 'package:pocket_tasks/screens/settings_screen.dart';
import 'package:pocket_tasks/screens/splash_screen.dart';
import 'package:pocket_tasks/state/theme_provider.dart';
import 'services/storage_service.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const ProviderScope(child: PocketTasksApp()));
}

class PocketTasksApp extends ConsumerWidget {
  const PocketTasksApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Pocket Tasks',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
      }
    );
  }
}