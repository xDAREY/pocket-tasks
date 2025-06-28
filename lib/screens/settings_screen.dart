import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';


final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final themeColorProvider = StateProvider<Color>((ref) => AppThemes.darkBrown);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    
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
                  color: Theme.of(context).primaryColor,
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
                      ref.read(themeModeProvider.notifier).state = 
                          value ? ThemeMode.dark : ThemeMode.light;
                    },
                    secondary: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Theme Color'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () {
                      _showColorPicker(context, ref);
                    },
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
                  color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('App Version'),
                    trailing: const Text('1.2.3'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.update,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Check for Updates'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {

                    },
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
                  color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text('Contact Us'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'oluwadare.emmanuel15@gmail.com',
                        queryParameters: {
                          'subject': 'QR Create App Feedback'
                        }
                      );
                      
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
                  queryParameters: {
                    'subject': 'QR Create App Feedback'
                  }
                );
                
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
  
  void _showColorPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _colorOption(context, ref, AppThemes.darkBrown),
                _colorOption(context, ref, AppThemes.lightBeige),
                _colorOption(context, ref, Colors.blue),
                _colorOption(context, ref, Colors.green),
                _colorOption(context, ref, Colors.red),
                _colorOption(context, ref, Colors.orange),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
  
  Widget _colorOption(BuildContext context, WidgetRef ref, Color color) {
    final currentColor = ref.watch(themeColorProvider);
    final isSelected = currentColor == color;
    
    return GestureDetector(
      onTap: () {
        ref.read(themeColorProvider.notifier).state = color;
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.white, width: 3)
              : null,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}