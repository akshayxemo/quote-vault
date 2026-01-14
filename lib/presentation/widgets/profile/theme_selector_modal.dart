import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class ThemeSelectorModal extends StatelessWidget {
  const ThemeSelectorModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Title
          ThemedText.heading(
            'Choose Theme',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          
          const SizedBox(height: 24),
          
          // Theme Options
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Column(
                children: [
                  // System Default
                  _buildThemeOption(
                    context: context,
                    title: 'System Default',
                    subtitle: 'Follow device settings',
                    icon: Icons.brightness_auto,
                    isSelected: themeProvider.currentThemeMode == ThemeMode.system,
                    onTap: () {
                      themeProvider.setThemeMode(ThemeMode.system);
                      Navigator.of(context).pop();
                    },
                  ),
                  
                  // Light Themes
                  _buildThemeOption(
                    context: context,
                    title: 'Minimalist Warm',
                    subtitle: 'Cream & Charcoal',
                    icon: Icons.light_mode,
                    isSelected: themeProvider.currentThemeMode == ThemeMode.light && 
                               themeProvider.currentThemeIndex == 0,
                    onTap: () {
                      themeProvider.setTheme(0, ThemeMode.light);
                      Navigator.of(context).pop();
                    },
                    colorPreview: const [Color(0xFFFDFCF8), Color(0xFF2D2D2D)],
                  ),
                  
                  _buildThemeOption(
                    context: context,
                    title: 'Earthy Sage',
                    subtitle: 'Muted Sage & Deep Forest',
                    icon: Icons.eco,
                    isSelected: themeProvider.currentThemeMode == ThemeMode.light && 
                               themeProvider.currentThemeIndex == 2,
                    onTap: () {
                      themeProvider.setTheme(2, ThemeMode.light);
                      Navigator.of(context).pop();
                    },
                    colorPreview: const [Color(0xFFEDF1E4), Color(0xFF1B261D)],
                  ),
                  
                  _buildThemeOption(
                    context: context,
                    title: 'Soft Terracotta',
                    subtitle: 'Dusty Rose & Rich Umber',
                    icon: Icons.palette,
                    isSelected: themeProvider.currentThemeMode == ThemeMode.light && 
                               themeProvider.currentThemeIndex == 3,
                    onTap: () {
                      themeProvider.setTheme(3, ThemeMode.light);
                      Navigator.of(context).pop();
                    },
                    colorPreview: const [Color(0xFFF4EAE6), Color(0xFF4A2C2A)],
                  ),
                  
                  // Dark Theme
                  _buildThemeOption(
                    context: context,
                    title: 'Deep Midnight',
                    subtitle: 'Dark Navy & Soft Silver',
                    icon: Icons.dark_mode,
                    isSelected: themeProvider.currentThemeMode == ThemeMode.dark,
                    onTap: () {
                      themeProvider.setTheme(1, ThemeMode.dark);
                      Navigator.of(context).pop();
                    },
                    colorPreview: const [Color(0xFF0B0E14), Color(0xFFE0E0E0)],
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    List<Color>? colorPreview,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Icon or Color Preview
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorPreview != null 
                    ? colorPreview[0] 
                    : Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                ),
              ),
              child: colorPreview != null
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorPreview[0],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorPreview[1],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Icon(
                      icon,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
            
            const SizedBox(width: 16),
            
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.body(
                    title,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 2),
                  ThemedText.caption(
                    subtitle,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            
            // Selection Indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
                size: 24,
              )
            else
              Icon(
                Icons.radio_button_unchecked,
                color: Colors.grey.withValues(alpha: 0.5),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}