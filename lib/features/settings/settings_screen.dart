import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          
          _buildSettingItem(
            context,
            icon: Icons.wb_sunny_outlined,
            title: 'Theme',
            subtitle: 'System default',
          ),
          _buildSettingItem(
            context,
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
          ),
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
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(icon, color: AppColors.primaryText),
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
