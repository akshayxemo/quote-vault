import 'package:flutter/material.dart';
import 'package:quote_vault/core/theme/app_themes.dart';

/// Enum for available theme types
enum ThemeType {
  minimalistWarm,
  deepMidnight,
  earthySage,
  softTerracotta,
}

/// Theme provider for managing app themes
class ThemeProvider extends ChangeNotifier {
  ThemeType _currentTheme = ThemeType.minimalistWarm;

  ThemeType get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      case ThemeType.minimalistWarm:
        return AppThemes.minimalistWarmTheme;
      case ThemeType.deepMidnight:
        return AppThemes.deepMidnightTheme;
      case ThemeType.earthySage:
        return AppThemes.earthySageTheme;
      case ThemeType.softTerracotta:
        return AppThemes.softTerracottaTheme;
    }
  }

  String get themeName {
    switch (_currentTheme) {
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

  void setTheme(ThemeType theme) {
    _currentTheme = theme;
    notifyListeners();
  }

  void toggleTheme() {
    final themes = ThemeType.values;
    final currentIndex = themes.indexOf(_currentTheme);
    final nextIndex = (currentIndex + 1) % themes.length;
    setTheme(themes[nextIndex]);
  }
}