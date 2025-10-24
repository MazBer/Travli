import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/services/translation_service.dart';
import '../../core/theme/theme_constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
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
              l10n.preferences,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          _buildThemeSwitcher(context, ref, themeMode, l10n),
          _buildColorSchemeSwitcher(context, ref, l10n),
          _buildColorSeedSelector(context, ref, l10n),
          _buildLanguageSelector(context, ref, l10n),
          _buildSettingItem(
            context,
            icon: Icons.straighten_outlined,
            title: l10n.units,
            subtitle: l10n.metric,
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
              l10n.account,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          _buildSettingItem(
            context,
            icon: Icons.person_outline,
            title: l10n.profile,
          ),
          _buildSettingItem(
            context,
            icon: Icons.login,
            title: l10n.signIn,
          ),
          
          // Info section
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Text(
              'Info',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              
              final info = snapshot.data!;
              
              // Extract build date from description if available
              String buildDate = 'Unknown';
              if (info.packageName.isNotEmpty) {
                // Try to extract from description: "... | Build: 2025-10-24"
                final descParts = (info.appName).split('|');
                if (descParts.length > 1) {
                  final buildPart = descParts.last.trim();
                  if (buildPart.startsWith('Build:')) {
                    buildDate = buildPart.replaceFirst('Build:', '').trim();
                  }
                }
              }
              
              // Fallback to current date if not found
              if (buildDate == 'Unknown') {
                buildDate = DateTime.now().toString().split(' ')[0];
              }
              
              return Column(
                children: [
                  _buildSettingItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'Version',
                    subtitle: '${info.version} (${info.buildNumber})',
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Build Date',
                    subtitle: buildDate,
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.code,
                    title: 'App Name',
                    subtitle: info.appName,
                  ),
                  _buildSettingItem(
                    context,
                    icon: Icons.tag,
                    title: 'Package',
                    subtitle: info.packageName,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorSchemeSwitcher(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
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
        l10n.colorScheme,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        useDynamicColor ? l10n.materialYou : 'Default',
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

  Widget _buildColorSeedSelector(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final useDynamicColor = ref.watch(useDynamicColorProvider);
    final currentColorSeed = ref.watch(colorSeedProvider);

    // Only show if Material You is disabled
    if (useDynamicColor) {
      return const SizedBox.shrink();
    }

    return ListTile(
      leading: Container(
        width: AppSpacing.avatarSm,
        height: AppSpacing.avatarSm,
        decoration: BoxDecoration(
          color: currentColorSeed.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          Icons.color_lens,
          color: currentColorSeed.color,
        ),
      ),
      title: Text(
        l10n.themeColor,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(
        currentColorSeed.label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: PopupMenuButton<ColorSeed>(
        icon: const Icon(Icons.arrow_forward_ios, size: 16),
        onSelected: (ColorSeed seed) {
          ref.read(colorSeedProvider.notifier).setColorSeed(seed);
        },
        itemBuilder: (BuildContext context) {
          return ColorSeed.values.map((seed) {
            return PopupMenuItem<ColorSeed>(
              value: seed,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: seed.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(seed.label),
                  if (currentColorSeed == seed) ...[
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

  Widget _buildLanguageSelector(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
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
        l10n.language,
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

  Widget _buildThemeSwitcher(BuildContext context, WidgetRef ref, ThemeMode currentMode, AppLocalizations l10n) {
    String getThemeLabel(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return l10n.themeLight;
        case ThemeMode.dark:
          return l10n.themeDark;
        case ThemeMode.system:
          return l10n.themeSystem;
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
        l10n.theme,
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
                Text(l10n.themeSystem),
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
                Text(l10n.themeLight),
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
                Text(l10n.themeDark),
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
