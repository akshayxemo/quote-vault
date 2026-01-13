import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common/custom_card.dart';
import '../widgets/common/theme_preview_card.dart';
import '../widgets/common/themed_text.dart';

class ThemeDemoScreen extends StatelessWidget {
  const ThemeDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemedText.heading(
              'Current Theme: ${themeProvider.themeName}',
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: AppConstants.largeSpacing),
            
            // Theme Selection Grid
            ThemedText.subText(
              'Available Themes',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: AppConstants.mediumSpacing),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: AppConstants.smallSpacing,
                mainAxisSpacing: AppConstants.smallSpacing,
              ),
              itemCount: ThemeType.values.length,
              itemBuilder: (context, index) {
                final theme = ThemeType.values[index];
                return ThemePreviewCard(
                  themeType: theme,
                  isSelected: themeProvider.currentTheme == theme,
                  onTap: () => themeProvider.setTheme(theme),
                );
              },
            ),
            
            const SizedBox(height: AppConstants.largeSpacing),
            
            // UI Components Demo
            ThemedText.subText(
              'UI Components',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: AppConstants.mediumSpacing),
            
            // Text Theme Showcase
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading(
                    'Text Theme Showcase',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  ThemedText.heading('Heading Text'),
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.subText('Sub Text - Secondary information'),
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.accent('Accent Text - Highlights and CTAs'),
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.body('Body Text - Main content and paragraphs'),
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.caption('Caption Text - Small details and metadata'),
                ],
              ),
            ),
            
            // Cards Demo
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading(
                    'Sample Card',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: AppConstants.smallSpacing),
                  ThemedText.body(
                    'This is a sample card showing how the current theme affects the appearance of UI components.',
                  ),
                ],
              ),
            ),
            
            // Buttons Demo
            const SizedBox(height: AppConstants.mediumSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Text'),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.mediumSpacing),
            
            // Text Styles Demo
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading(
                    'Typography Showcase',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: AppConstants.smallSpacing),
                  ThemedText.subText(
                    'Title Large',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  ThemedText.subText(
                    'Title Medium',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  ThemedText.body(
                    'Body Large - This is how regular text appears in the current theme.',
                  ),
                  ThemedText.body(
                    'Body Medium - Secondary text content.',
                    fontSize: 14,
                  ),
                  ThemedText.caption(
                    'Body Small - Caption or helper text.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: themeProvider.toggleTheme,
        tooltip: 'Switch Theme',
        child: const Icon(Icons.palette),
      ),
    );
  }
}