import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/core/settings/text_size_provider.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_bloc.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_event.dart';
import 'package:quote_vault/presentation/bloc/auth/auth_state.dart';
import 'package:quote_vault/presentation/widgets/profile/profile_header.dart';
import 'package:quote_vault/presentation/widgets/profile/settings_section.dart';
import 'package:quote_vault/presentation/widgets/profile/theme_selector_modal.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              const ProfileHeader(),
              
              const SizedBox(height: 32),
              
              // Appearance Section
              _buildSectionTitle('APPEARANCE'),
              const SizedBox(height: 16),
              SettingsSection(
                children: [
                  _buildThemeSelector(context),
                  _buildTextSizeSelector(context),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Notifications Section
              _buildSectionTitle('NOTIFICATIONS'),
              const SizedBox(height: 16),
              SettingsSection(
                children: [
                  _buildDailyReminders(context),
                  _buildNotificationTime(context),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Account & Support Section
              _buildSectionTitle('ACCOUNT & SUPPORT'),
              const SizedBox(height: 16),
              SettingsSection(
                children: [
                  _buildHelpFeedback(context),
                  _buildPrivacyPolicy(context),
                  _buildSignOut(context),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // App Version
              Center(
                child: Column(
                  children: [
                    ThemedText.caption(
                      'QUOTEVAULT V3.0.1',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                    const SizedBox(height: 4),
                    ThemedText.caption(
                      '"Simplicity is the ultimate sophistication."',
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ThemedText.caption(
      title,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListTile(
          leading: Icon(
            _getThemeIcon(themeProvider.currentThemeMode),
            color: Theme.of(context).iconTheme.color,
          ),
          title: ThemedText.body('Theme'),
          subtitle: ThemedText.caption(
            _getThemeDisplayName(themeProvider.currentThemeMode),
            fontSize: 12,
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showThemeSelector(context),
        );
      },
    );
  }

  Widget _buildTextSizeSelector(BuildContext context) {
    return Consumer<TextSizeProvider>(
      builder: (context, textSizeProvider, child) {
        return Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.text_fields,
                color: Theme.of(context).iconTheme.color,
              ),
              title: ThemedText.body('Text Size'),
              subtitle: ThemedText.caption(
                textSizeProvider.getTextSizeLabel(),
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 8),
              child: Row(
                children: [
                  ThemedText.caption('A', fontSize: 12),
                  Expanded(
                    child: Slider(
                      value: textSizeProvider.textSize,
                      min: textSizeProvider.minTextSize,
                      max: textSizeProvider.maxTextSize,
                      divisions: 10,
                      onChanged: (value) {
                        textSizeProvider.setTextSize(value);
                      },
                      activeColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  ThemedText.caption('A', fontSize: 18),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDailyReminders(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.notifications_outlined,
        color: Theme.of(context).iconTheme.color,
      ),
      title: ThemedText.body('Daily Reminders'),
      subtitle: ThemedText.caption('One quote at a time', fontSize: 12),
      trailing: Switch(
        value: true,
        onChanged: (value) {
          // TODO: Implement daily reminders toggle
        },
        activeColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }

  Widget _buildNotificationTime(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.schedule,
        color: Theme.of(context).iconTheme.color,
      ),
      title: ThemedText.body('Notification Time'),
      trailing: ThemedText.body(
        '08:30 AM',
        fontWeight: FontWeight.w500,
      ),
      onTap: () => _showTimePicker(context),
    );
  }

  Widget _buildHelpFeedback(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.help_outline,
        color: Theme.of(context).iconTheme.color,
      ),
      title: ThemedText.body('Help & Feedback'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Navigate to help & feedback
      },
    );
  }

  Widget _buildPrivacyPolicy(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.privacy_tip_outlined,
        color: Theme.of(context).iconTheme.color,
      ),
      title: ThemedText.body('Privacy Policy'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Navigate to privacy policy
      },
    );
  }

  Widget _buildSignOut(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      title: ThemedText.body(
        'Sign Out',
        customColor: Colors.red,
      ),
      onTap: () => _showSignOutDialog(context),
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _getThemeDisplayName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ThemeSelectorModal(),
    );
  }

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 30),
    );
    if (picked != null) {
      // TODO: Save notification time
    }
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(dialogContext).pop();
            context.go('/signin');
          } else if (state is AuthError) {
            Navigator.of(dialogContext).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Sign out failed: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: AlertDialog(
          title: ThemedText.heading('Sign Out'),
          content: ThemedText.body('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: ThemedText.body('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const SignOutEvent());
              },
              child: ThemedText.body('Sign Out', customColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}