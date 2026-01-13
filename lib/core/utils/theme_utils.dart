import 'package:flutter/material.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';

/// Utility functions for theme-related operations
class ThemeUtils {
  /// Check if the current theme is dark
  static bool isDarkTheme(ThemeType themeType) {
    return themeType == ThemeType.deepMidnight;
  }

  /// Get contrast color for text based on background
  static Color getContrastColor(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Get theme-appropriate shadow color
  static Color getShadowColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.grey.withValues(alpha: 0.2);
  }

  /// Get theme name from ThemeType enum
  static String getThemeDisplayName(ThemeType themeType) {
    switch (themeType) {
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
}