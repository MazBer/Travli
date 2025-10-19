import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/services/translation_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Preferences section
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text(
              'Preferences',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          _buildThemeSwitcher(context, ref, themeMode),
          _buildColorSchemeSwitcher(context, ref),
          _buildLanguageSelector(context, ref),
          _buildSettingItem(
            context,
            icon: Icons.straighten_outlined,
            title: 'Units',
            subtitle: 'Metric',
          ),
          
          // Account section
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text(
              'Account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          _buildSettingItem(
            context,
            icon: Icons.person_outline,
            title: 'Profile',
          ),
          _buildSettingItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
          ),
          _buildSettingItem(
            context,
            icon: Icons.shield_outlined,
            title: 'Privacy',
          ),
          _buildSettingItem(
            context,
            icon: Icons.help_outline,
            title: 'Help',
          ),
          _buildSettingItem(
            context,
            icon: Icons.info_outline,
            title: 'About',
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeSwitcher(BuildContext context, WidgetRef ref) {
    final useDynamicColor = ref.watch(useDynamicColorProvider);

    return ListTile(
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: AppSpacing.avatarSm,
        height: AppSpacing.avatarSm,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          useDynamicColor ? Icons.palette : Icons.palette_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        'Color Scheme',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        useDynamicColor ? 'Material You' : 'Default',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: Switch(
        value: useDynamicColor,
        onChanged: (value) {
          ref.read(useDynamicColorProvider.notifier).setUseDynamicColor(value);
        },
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    final languageName = TranslationService.supportedLanguages[currentLanguage] ?? 'English';

    return ListTile(
      leading: Container(
        width: AppSpacing.avatarSm,
        height: AppSpacing.avatarSm,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.language,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        'Language',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        languageName,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.arrow_forward_ios, size: 16),
        onSelected: (String languageCode) {
          ref.read(languageProvider.notifier).setLanguage(languageCode);
        },
        itemBuilder: (BuildContext context) {
          return TranslationService.supportedLanguages.entries.map((entry) {
            return PopupMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Text(entry.value),
                  if (currentLanguage == entry.key) ...[
                    const Spacer(),
                    Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                  ],
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    String getThemeLabel(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return 'Light';
        case ThemeMode.dark:
          return 'Dark';
        case ThemeMode.system:
          return 'System default';
      }
    }

    IconData getThemeIcon(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return Icons.wb_sunny;
        case ThemeMode.dark:
          return Icons.nightlight_round;
        case ThemeMode.system:
          return Icons.brightness_auto;
      }
    }

    return ListTile(
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: AppSpacing.avatarSm,
        height: AppSpacing.avatarSm,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          getThemeIcon(currentMode),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        'Theme',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        getThemeLabel(currentMode),
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: PopupMenuButton<ThemeMode>(
        icon: const Icon(Icons.arrow_forward_ios, size: 16),
        onSelected: (ThemeMode mode) {
          ref.read(themeModeProvider.notifier).setThemeMode(mode);
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: ThemeMode.system,
            child: Row(
              children: [
                Icon(Icons.brightness_auto, size: 20),
                const SizedBox(width: 12),
                const Text('System default'),
                if (currentMode == ThemeMode.system) ...[
                  const Spacer(),
                  Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                ],
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.light,
            child: Row(
              children: [
                Icon(Icons.wb_sunny, size: 20),
                const SizedBox(width: 12),
                const Text('Light'),
                if (currentMode == ThemeMode.light) ...[
                  const Spacer(),
                  Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                ],
              ],
            ),
          ),
          PopupMenuItem(
            value: ThemeMode.dark,
            child: Row(
              children: [
                Icon(Icons.nightlight_round, size: 20),
                const SizedBox(width: 12),
                const Text('Dark'),
                if (currentMode == ThemeMode.dark) ...[
                  const Spacer(),
                  Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return ListTile(
      leading: Container(
        width: AppSpacing.avatarSm,
        height: AppSpacing.avatarSm,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.labelMedium,
            )
          : null,
      onTap: () {
        // TODO: Navigate to setting detail
      },
    );
  }
}
