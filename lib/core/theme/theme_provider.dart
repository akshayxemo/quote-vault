import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quote_vault/core/theme/app_themes.dart';

/// Enum for available theme types
enum ThemeType {
  minimalistWarm,
  deepMidnight,
  earthySage,
  softTerracotta,
}

/// Theme provider for managing app themes with system mode support
class ThemeProvider extends ChangeNotifier {
  ThemeType _currentTheme = ThemeType.minimalistWarm;
  ThemeMode _themeMode = ThemeMode.system;
  
  static const String _themeKey = 'selected_theme';
  static const String _themeModeKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  ThemeType get currentTheme => _currentTheme;
  ThemeMode get currentThemeMode => _themeMode;
  
  int get currentThemeIndex {
    switch (_currentTheme) {
      case ThemeType.minimalistWarm:
        return 0;
      case ThemeType.deepMidnight:
        return 1;
      case ThemeType.earthySage:
        return 2;
      case ThemeType.softTerracotta:
        return 3;
    }
  }

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

  ThemeData get darkThemeData {
    // Always use Deep Midnight for dark mode
    return AppThemes.deepMidnightTheme;
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

  void setTheme(int themeIndex, [ThemeMode? mode]) {
    final themes = [
      ThemeType.minimalistWarm,
      ThemeType.deepMidnight,
      ThemeType.earthySage,
      ThemeType.softTerracotta,
    ];
    
    if (themeIndex >= 0 && themeIndex < themes.length) {
      _currentTheme = themes[themeIndex];
      
      if (mode != null) {
        _themeMode = mode;
      } else {
        // If setting a light theme, switch to light mode
        // If setting dark theme (Deep Midnight), switch to dark mode
        _themeMode = themeIndex == 1 ? ThemeMode.dark : ThemeMode.light;
      }
      
      _saveThemeToPrefs();
      notifyListeners();
    }
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeToPrefs();
    notifyListeners();
  }

  void toggleTheme() {
    final themes = ThemeType.values;
    final currentIndex = themes.indexOf(_currentTheme);
    final nextIndex = (currentIndex + 1) % themes.length;
    setTheme(nextIndex);
  }

  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      final themeModeIndex = prefs.getInt(_themeModeKey) ?? 0;
      
      final themes = [
        ThemeType.minimalistWarm,
        ThemeType.deepMidnight,
        ThemeType.earthySage,
        ThemeType.softTerracotta,
      ];
      
      final themeModes = [
        ThemeMode.system,
        ThemeMode.light,
        ThemeMode.dark,
      ];
      
      if (themeIndex >= 0 && themeIndex < themes.length) {
        _currentTheme = themes[themeIndex];
      }
      
      if (themeModeIndex >= 0 && themeModeIndex < themeModes.length) {
        _themeMode = themeModes[themeModeIndex];
      }
      
      notifyListeners();
    } catch (e) {
      // Handle error silently, use defaults
    }
  }

  Future<void> _saveThemeToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, currentThemeIndex);
      
      final themeModeIndex = _themeMode == ThemeMode.system 
          ? 0 
          : _themeMode == ThemeMode.light 
              ? 1 
              : 2;
      await prefs.setInt(_themeModeKey, themeModeIndex);
    } catch (e) {
      // Handle error silently
    }
  }
}