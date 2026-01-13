import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Theme configurations for the Quote Vault app
class AppThemes {
  // Minimalist Warm Theme (Normal/Base)
  static ThemeData get minimalistWarmTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.minimalistCharcoal,
        onPrimary: AppColors.minimalistCream,
        secondary: AppColors.minimalistCharcoal.withValues(alpha: 0.7),
        onSecondary: AppColors.minimalistCream,
        surface: AppColors.minimalistCream,
        onSurface: AppColors.minimalistCharcoal,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.minimalistCream,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.minimalistCream,
        foregroundColor: AppColors.minimalistCharcoal,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.minimalistCream,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.minimalistCharcoal,
          foregroundColor: AppColors.minimalistCream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Deep Midnight Theme (Dark)
  static ThemeData get deepMidnightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.midnightSilver,
        onPrimary: AppColors.midnightNavy,
        secondary: AppColors.midnightSilver.withValues(alpha: 0.7),
        onSecondary: AppColors.midnightNavy,
        surface: AppColors.midnightNavy,
        onSurface: AppColors.midnightSilver,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.midnightNavy,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.midnightNavy,
        foregroundColor: AppColors.midnightSilver,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.midnightNavy.withValues(alpha: 0.8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.midnightSilver,
          foregroundColor: AppColors.midnightNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Earthy Sage Theme
  static ThemeData get earthySageTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.deepForest,
        onPrimary: AppColors.sageGreen,
        secondary: AppColors.deepForest.withValues(alpha: 0.7),
        onSecondary: AppColors.sageGreen,
        surface: AppColors.sageGreen,
        onSurface: AppColors.deepForest,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.sageGreen,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.sageGreen,
        foregroundColor: AppColors.deepForest,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.sageGreen,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepForest,
          foregroundColor: AppColors.sageGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Soft Terracotta Theme
  static ThemeData get softTerracottaTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.richUmber,
        onPrimary: AppColors.dustyRose,
        secondary: AppColors.richUmber.withValues(alpha: 0.7),
        onSecondary: AppColors.dustyRose,
        surface: AppColors.dustyRose,
        onSurface: AppColors.richUmber,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.dustyRose,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dustyRose,
        foregroundColor: AppColors.richUmber,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.dustyRose,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.richUmber,
          foregroundColor: AppColors.dustyRose,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}