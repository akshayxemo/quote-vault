import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Custom text theme extension for dynamic text colors
@immutable
class AppTextColors extends ThemeExtension<AppTextColors> {
  final Color headingColor;
  final Color subTextColor;
  final Color accentColor;
  final Color bodyTextColor;
  final Color captionColor;

  const AppTextColors({
    required this.headingColor,
    required this.subTextColor,
    required this.accentColor,
    required this.bodyTextColor,
    required this.captionColor,
  });

  // Minimalist Warm theme text colors
  static const AppTextColors minimalistWarm = AppTextColors(
    headingColor: AppColors.minimalistCharcoal,
    subTextColor: Color(0xFF5D5D5D), // Lighter charcoal
    accentColor: AppColors.minimalistAccent,
    bodyTextColor: AppColors.minimalistCharcoal,
    captionColor: Color(0xFF8A8A8A), // Even lighter for captions
  );

  // Deep Midnight theme text colors
  static const AppTextColors deepMidnight = AppTextColors(
    headingColor: AppColors.midnightSilver,
    subTextColor: Color(0xFFB0B0B0), // Dimmed silver
    accentColor: AppColors.midnightAccent,
    bodyTextColor: AppColors.midnightSilver,
    captionColor: Color(0xFF909090), // Dimmed for captions
  );

  // Earthy Sage theme text colors
  static const AppTextColors earthySage = AppTextColors(
    headingColor: AppColors.deepForest,
    subTextColor: Color(0xFF4A5A4D), // Lighter forest
    accentColor: AppColors.sageAccent,
    bodyTextColor: AppColors.deepForest,
    captionColor: Color(0xFF6B7A6E), // Even lighter forest
  );

  // Soft Terracotta theme text colors
  static const AppTextColors softTerracotta = AppTextColors(
    headingColor: AppColors.richUmber,
    subTextColor: Color(0xFF6B4A48), // Lighter umber
    accentColor: AppColors.terracottaAccent,
    bodyTextColor: AppColors.richUmber,
    captionColor: Color(0xFF8A6B69), // Even lighter umber
  );

  @override
  ThemeExtension<AppTextColors> copyWith({
    Color? headingColor,
    Color? subTextColor,
    Color? accentColor,
    Color? bodyTextColor,
    Color? captionColor,
  }) {
    return AppTextColors(
      headingColor: headingColor ?? this.headingColor,
      subTextColor: subTextColor ?? this.subTextColor,
      accentColor: accentColor ?? this.accentColor,
      bodyTextColor: bodyTextColor ?? this.bodyTextColor,
      captionColor: captionColor ?? this.captionColor,
    );
  }

  @override
  ThemeExtension<AppTextColors> lerp(
    covariant ThemeExtension<AppTextColors>? other,
    double t,
  ) {
    if (other is! AppTextColors) {
      return this;
    }

    return AppTextColors(
      headingColor: Color.lerp(headingColor, other.headingColor, t)!,
      subTextColor: Color.lerp(subTextColor, other.subTextColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      bodyTextColor: Color.lerp(bodyTextColor, other.bodyTextColor, t)!,
      captionColor: Color.lerp(captionColor, other.captionColor, t)!,
    );
  }
}

/// Extension to easily access text colors from BuildContext
extension AppTextColorsExtension on BuildContext {
  AppTextColors get textColors =>
      Theme.of(this).extension<AppTextColors>() ?? AppTextColors.minimalistWarm;
}