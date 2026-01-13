import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'text_theme_extension.dart';

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
        tertiary: AppColors.minimalistAccent,
        onTertiary: AppColors.minimalistCream,
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
      textTheme: _buildTextTheme(AppTextColors.minimalistWarm),
      extensions: const [
        AppTextColors.minimalistWarm,
      ],
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
        tertiary: AppColors.midnightAccent,
        onTertiary: AppColors.midnightNavy,
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
      textTheme: _buildTextTheme(AppTextColors.deepMidnight),
      extensions: const [
        AppTextColors.deepMidnight,
      ],
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
        tertiary: AppColors.sageAccent,
        onTertiary: AppColors.sageGreen,
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
      textTheme: _buildTextTheme(AppTextColors.earthySage),
      extensions: const [
        AppTextColors.earthySage,
      ],
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
        tertiary: AppColors.terracottaAccent,
        onTertiary: AppColors.dustyRose,
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
      textTheme: _buildTextTheme(AppTextColors.softTerracotta),
      extensions: const [
        AppTextColors.softTerracotta,
      ],
    );
  }

  /// Helper method to build text theme with custom colors
  static TextTheme _buildTextTheme(AppTextColors textColors) {
    return TextTheme(
      // Display styles (largest)
      displayLarge: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.w600,
      ),
      
      // Headline styles
      headlineLarge: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.w600,
      ),
      
      // Title styles
      titleLarge: TextStyle(
        color: textColors.headingColor,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: textColors.subTextColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: textColors.subTextColor,
        fontWeight: FontWeight.w500,
      ),
      
      // Body styles
      bodyLarge: TextStyle(
        color: textColors.bodyTextColor,
      ),
      bodyMedium: TextStyle(
        color: textColors.bodyTextColor,
      ),
      bodySmall: TextStyle(
        color: textColors.subTextColor,
      ),
      
      // Label styles
      labelLarge: TextStyle(
        color: textColors.accentColor,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: textColors.accentColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: textColors.captionColor,
      ),
    );
  }
}