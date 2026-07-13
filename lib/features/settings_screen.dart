import 'package:flutter/material.dart';
import '../state/app_scope.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _edit(
    BuildContext context,
    String title,
    int initial,
    ValueChanged<int> save,
  ) async {
    final text = TextEditingController(text: '$initial');
    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: text,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(suffixText: 'ml'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = int.tryParse(text.text.trim());
              if (value != null && value > 0) Navigator.pop(dialogContext, value);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) save(result);
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) => ListView(children: [
          ListTile(
            title: const Text('Daily goal'),
            subtitle: Text('${controller.settings.dailyGoalMl} ml'),
            onTap: () => _edit(context, 'Daily goal',
                controller.settings.dailyGoalMl, controller.setDailyGoal),
          ),
          ListTile(
            title: const Text('Default cup size'),
            subtitle: Text('${controller.settings.defaultCupMl} ml'),
            onTap: () => _edit(context, 'Default cup size',
                controller.settings.defaultCupMl, controller.setDefaultCup),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: controller.settings.themeMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (value) {
                if (value != null) controller.setTheme(value);
              },
            ),
          ),
          const Divider(),
          ListTile(title: const Text('Reset today'), onTap: controller.resetToday),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
            ),
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
            ),
          ),
          const ListTile(title: Text('App version'), trailing: Text('1.0.0')),
          ListTile(
            leading: const Icon(Icons.delete_forever_outlined),
            title: const Text('Clear all data'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: controller.clearAllData,
          ),
        ]),
      ),
    );
  }
}
