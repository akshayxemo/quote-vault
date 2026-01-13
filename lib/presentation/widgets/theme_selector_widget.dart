import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/constants/app_constants.dart';

class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Theme',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          ...ThemeType.values.map((theme) {
            return ListTile(
              title: Text(_getThemeName(theme)),
              subtitle: Text(_getThemeDescription(theme)),
              leading: CircleAvatar(
                backgroundColor: _getThemeColor(theme),
                radius: 12,
              ),
              trailing: themeProvider.currentTheme == theme
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                themeProvider.setTheme(theme);
                Navigator.pop(context);
              },
            );
          }),
          const SizedBox(height: AppConstants.smallSpacing),
        ],
      ),
    );
  }

  String _getThemeName(ThemeType theme) {
    switch (theme) {
      case ThemeType.minimalistWarm:
        return 'Minimalist Warm';
      case ThemeType.deepMidnight:
        return 'Deep Midnight';
      case ThemeType.earthySage:
        return 'Earthy Sage';
      case ThemeType.softTerracotta:
        return 'Soft Terracotta';
    }
  }

  String _getThemeDescription(ThemeType theme) {
    switch (theme) {
      case ThemeType.minimalistWarm:
        return 'Cream & Charcoal - Clean and warm';
      case ThemeType.deepMidnight:
        return 'Dark Navy & Silver - Deep and elegant';
      case ThemeType.earthySage:
        return 'Sage & Forest - Natural and calming';
      case ThemeType.softTerracotta:
        return 'Rose & Umber - Warm and cozy';
    }
  }

  Color _getThemeColor(ThemeType theme) {
    switch (theme) {
      case ThemeType.minimalistWarm:
        return const Color(0xFF2D2D2D); // Charcoal
      case ThemeType.deepMidnight:
        return const Color(0xFF0B0E14); // Navy
      case ThemeType.earthySage:
        return const Color(0xFF1B261D); // Forest
      case ThemeType.softTerracotta:
        return const Color(0xFF4A2C2A); // Umber
    }
  }
}