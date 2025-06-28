import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/services/version_service.dart';
import 'package:pocket_tasks/state/theme_provider.dart';
import 'package:pocket_tasks/utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeProvider); 
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                'General',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : AppThemes.darkBrown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Switch between light and dark themes'),
                    value: themeMode == ThemeMode.dark ||
                        (themeMode == ThemeMode.system && isDarkMode),
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).setTheme(
                        value ? ThemeMode.dark : ThemeMode.light
                      );
                    },
                    secondary: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary, 
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
              child: Text(
                'App Information',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : AppThemes.darkBrown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                    ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('App Version'),
                    subtitle: ref.watch(versionProvider).when(
                      data: (version) => Text(
                        version,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      loading: () => const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.grey),
                      ),
                      error: (error, stack) => const Text(
                        'Error',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ),
                  ListTile(
                    leading: Icon(
                      Icons.update,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Check for Updates'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
              child: Text(
                'Support',
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : AppThemes.darkBrown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Contact Us'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'oluwadare.emmanuel15@gmail.com',
                          queryParameters: {
                            'subject': 'Pocket Tasks App Feedback'
                          });

                      if (await canLaunchUrl(emailLaunchUri)) {
                        await launchUrl(emailLaunchUri);
                      } else {
                        if (context.mounted) {
                          _showContactDialog(context);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Developer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('For any queries or feedback, please contact:'),
            const SizedBox(height: 8),
            const SelectableText('oluwadare.emmanuel15@gmail.com'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Send Email'),
              onPressed: () async {
                Navigator.pop(context);

                final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'oluwadare.emmanuel15@gmail.com',
                    queryParameters: {'subject': 'Pocket Tasks App Feedback'}); 

                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}