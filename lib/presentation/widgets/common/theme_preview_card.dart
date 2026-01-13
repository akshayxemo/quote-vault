import 'package:flutter/material.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

/// Preview card showing theme colors
class ThemePreviewCard extends StatelessWidget {
  final ThemeType themeType;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemePreviewCard({
    super.key,
    required this.themeType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getThemeColors(themeType);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppConstants.smallSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          border: Border.all(
            color: isSelected ? colors.primary : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // Color preview
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.mediumRadius),
                  topRight: Radius.circular(AppConstants.mediumRadius),
                ),
                gradient: LinearGradient(
                  colors: [colors.background, colors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Theme name
            Padding(
              padding: const EdgeInsets.all(AppConstants.smallSpacing),
              child: Column(
                children: [
                  Text(
                    _getThemeName(themeType),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ThemeColors _getThemeColors(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.minimalistWarm:
        return _ThemeColors(
          primary: AppColors.minimalistCharcoal,
          background: AppColors.minimalistCream,
        );
      case ThemeType.deepMidnight:
        return _ThemeColors(
          primary: AppColors.midnightSilver,
          background: AppColors.midnightNavy,
        );
      case ThemeType.earthySage:
        return _ThemeColors(
          primary: AppColors.deepForest,
          background: AppColors.sageGreen,
        );
      case ThemeType.softTerracotta:
        return _ThemeColors(
          primary: AppColors.richUmber,
          background: AppColors.dustyRose,
        );
    }
  }

  String _getThemeName(ThemeType themeType) {
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

class _ThemeColors {
  final Color primary;
  final Color background;

  _ThemeColors({required this.primary, required this.background});
}