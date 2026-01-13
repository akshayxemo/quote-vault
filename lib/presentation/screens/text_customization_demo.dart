import 'package:flutter/material.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/common/custom_card.dart';

class TextCustomizationDemo extends StatelessWidget {
  const TextCustomizationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Customization Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.mediumSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Usage
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Basic Text Styles'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  ThemedText.heading('Heading Text'),
                  ThemedText.subText('Sub Text'),
                  ThemedText.accent('Accent Text'),
                  ThemedText.body('Body Text'),
                  ThemedText.caption('Caption Text'),
                ],
              ),
            ),
            
            // Font Customization
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Font Customization'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  // Font sizes
                  ThemedText.accent('Small Text', fontSize: 10),
                  ThemedText.accent('Medium Text', fontSize: 16),
                  ThemedText.accent('Large Text', fontSize: 24),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Font weights
                  ThemedText.body('Light Weight', fontWeight: FontWeight.w300),
                  ThemedText.body('Normal Weight', fontWeight: FontWeight.w400),
                  ThemedText.body('Medium Weight', fontWeight: FontWeight.w500),
                  ThemedText.body('Bold Weight', fontWeight: FontWeight.w700),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Font styles
                  ThemedText.subText('Normal Style'),
                  ThemedText.subText('Italic Style', fontStyle: FontStyle.italic),
                ],
              ),
            ),
            
            // Spacing and Layout
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Spacing & Layout'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  // Letter spacing
                  ThemedText.accent('Normal Spacing'),
                  ThemedText.accent('Wide Spacing', letterSpacing: 2.0),
                  ThemedText.accent('EXTRA WIDE', letterSpacing: 4.0),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Line height
                  ThemedText.body(
                    'This is a paragraph with normal line height. Lorem ipsum dolor sit amet.',
                  ),
                  ThemedText.body(
                    'This is a paragraph with increased line height for better readability. Lorem ipsum dolor sit amet.',
                    height: 1.6,
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Text alignment
                  ThemedText.subText('Left Aligned', textAlign: TextAlign.left),
                  ThemedText.subText('Center Aligned', textAlign: TextAlign.center),
                  ThemedText.subText('Right Aligned', textAlign: TextAlign.right),
                ],
              ),
            ),
            
            // Decorations
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Text Decorations'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  ThemedText.accent('Underlined Text', decoration: TextDecoration.underline),
                  ThemedText.accent('Overlined Text', decoration: TextDecoration.overline),
                  ThemedText.accent('Strikethrough Text', decoration: TextDecoration.lineThrough),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Custom decoration styles
                  ThemedText.body(
                    'Dotted Underline',
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                  ),
                  ThemedText.body(
                    'Dashed Underline',
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                  ThemedText.body(
                    'Thick Underline',
                    decoration: TextDecoration.underline,
                    decorationThickness: 3.0,
                  ),
                ],
              ),
            ),
            
            // Shadows and Effects
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Shadows & Effects'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  ThemedText.accent(
                    'Subtle Shadow',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.heading(
                    'Dramatic Shadow',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  ThemedText.accent(
                    'Glow Effect',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 0),
                        blurRadius: 8,
                        color: Colors.blue.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Advanced Features
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Advanced Features'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  // Custom color override
                  ThemedText.body(
                    'Custom Color Override',
                    customColor: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // With padding
                  ThemedText.accent(
                    'Text with Padding',
                    padding: const EdgeInsets.all(12),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Max lines and overflow
                  ThemedText.body(
                    'This is a very long text that will be truncated after two lines. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: AppConstants.smallSpacing),
                  
                  // Word spacing
                  ThemedText.subText(
                    'Words with extra spacing between them',
                    wordSpacing: 4.0,
                  ),
                ],
              ),
            ),
            
            // Real-world Examples
            CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThemedText.heading('Real-world Examples'),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  
                  // Quote card example
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ThemedText.body(
                          '"The only way to do great work is to love what you do."',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          height: 1.4,
                        ),
                        const SizedBox(height: 8),
                        ThemedText.caption(
                          '— Steve Jobs',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        const SizedBox(height: 8),
                        ThemedText.caption(
                          'Added 2 hours ago',
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}