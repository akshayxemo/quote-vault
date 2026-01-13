import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common/custom_card.dart';
import '../widgets/common/theme_preview_card.dart';

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
            Text(
              'Current Theme: ${themeProvider.themeName}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.largeSpacing),
            
            // Theme Selection Grid
            Text(
              'Available Themes',
              style: Theme.of(context).textTheme.titleLarge,
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
            Text(
              'UI Components',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.mediumSpacing),
            
            // Cards Demo
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample Card',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.smallSpacing),
                  Text(
                    'This is a sample card showing how the current theme affects the appearance of UI components.',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                  Text(
                    'Typography Showcase',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppConstants.smallSpacing),
                  Text(
                    'Title Large',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Title Medium',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Body Large - This is how regular text appears in the current theme.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Body Medium - Secondary text content.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Body Small - Caption or helper text.',
                    style: Theme.of(context).textTheme.bodySmall,
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