# Dynamic Text Theme System

This document explains how to use the dynamic text theme system that automatically adapts colors based on the current theme.

## 🎨 Text Color Types

### 1. **Heading Color**
- **Purpose**: Main headings, titles, and primary text
- **Usage**: Page titles, section headers, important labels
- **Weight**: Usually bold or semi-bold

### 2. **Sub Text Color**
- **Purpose**: Secondary text, subtitles, and supporting information
- **Usage**: Descriptions, secondary labels, metadata
- **Weight**: Medium to normal

### 3. **Accent Color**
- **Purpose**: Highlights, call-to-actions, and emphasis
- **Usage**: Buttons, links, important highlights, badges
- **Weight**: Medium to bold

### 4. **Body Text Color**
- **Purpose**: Main content and readable text
- **Usage**: Paragraphs, main content, general text
- **Weight**: Normal

### 5. **Caption Color**
- **Purpose**: Small details, hints, and less important text
- **Usage**: Timestamps, helper text, footnotes
- **Weight**: Light to normal

## 🎯 Theme-Specific Colors

### Minimalist Warm Theme
- **Heading**: Dark Charcoal (#2D2D2D)
- **Sub Text**: Medium Gray (#5D5D5D)
- **Accent**: Warm Brown (#8B7355)
- **Body**: Dark Charcoal (#2D2D2D)
- **Caption**: Light Gray (#8A8A8A)

### Deep Midnight Theme (Dark)
- **Heading**: Soft Silver (#E0E0E0)
- **Sub Text**: Dimmed Silver (#B0B0B0)
- **Accent**: Light Blue (#64B5F6)
- **Body**: Soft Silver (#E0E0E0)
- **Caption**: Medium Gray (#909090)

### Earthy Sage Theme
- **Heading**: Deep Forest (#1B261D)
- **Sub Text**: Medium Forest (#4A5A4D)
- **Accent**: Fresh Green (#7CB342)
- **Body**: Deep Forest (#1B261D)
- **Caption**: Light Forest (#6B7A6E)

### Soft Terracotta Theme
- **Heading**: Rich Umber (#4A2C2A)
- **Sub Text**: Medium Umber (#6B4A48)
- **Accent**: Warm Terracotta (#D4826B)
- **Body**: Rich Umber (#4A2C2A)
- **Caption**: Light Umber (#8A6B69)

## 🚀 How to Use

### Method 1: ThemedText Widget (Recommended)

```dart
import '../widgets/common/themed_text.dart';

// Heading text
ThemedText.heading('Main Title')

// Sub text
ThemedText.subText('Secondary information')

// Accent text
ThemedText.accent('Call to Action')

// Body text
ThemedText.body('Main content paragraph')

// Caption text
ThemedText.caption('Small details')
```

### Method 2: Direct Access via Context

```dart
import '../../core/theme/text_theme_extension.dart';

// Access colors directly
final textColors = context.textColors;

Text(
  'Custom text',
  style: TextStyle(
    color: textColors.headingColor,
    fontWeight: FontWeight.bold,
  ),
)
```

### Method 3: Theme-Based Text Styles

```dart
// Use the built-in text theme (automatically themed)
Text(
  'Heading',
  style: Theme.of(context).textTheme.headlineMedium,
)

Text(
  'Body text',
  style: Theme.of(context).textTheme.bodyLarge,
)
```

## 🎨 Customization Options

### ThemedText Widget Options

```dart
ThemedText.heading(
  'Custom Heading',
  fontSize: 24,           // Custom font size
  fontWeight: FontWeight.bold,  // Custom weight
  textAlign: TextAlign.center,  // Alignment
  maxLines: 2,           // Line limit
  overflow: TextOverflow.ellipsis,  // Overflow handling
)
```

## 📱 Examples in Practice

### Splash Screen
```dart
ThemedText.accent(
  'CURATED WISDOM',
  fontSize: 12,
  fontWeight: FontWeight.w500,
  textAlign: TextAlign.center,
)

ThemedText.subText(
  '"Words are our most inexhaustible source of magic."',
  textAlign: TextAlign.center,
  fontWeight: FontWeight.w400,
)
```

### Home Screen
```dart
ThemedText.heading(
  'Current Theme: ${themeProvider.themeName}',
  textAlign: TextAlign.center,
)

ThemedText.body(
  'You have pushed the button this many times:',
)

ThemedText.accent(
  '$_counter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
)
```

### Cards and Lists
```dart
CustomCard(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ThemedText.heading('Card Title'),
      ThemedText.body('Card content goes here...'),
      ThemedText.caption('Last updated: 2 hours ago'),
    ],
  ),
)
```

## 🔧 Benefits

1. **Automatic Theme Adaptation**: Colors change automatically when themes switch
2. **Consistent Typography**: Unified text styling across the app
3. **Easy to Use**: Simple widget API with sensible defaults
4. **Customizable**: Override any property when needed
5. **Type Safe**: Compile-time checking for text styles
6. **Performance**: Efficient color resolution using theme extensions

## 🎯 Best Practices

1. **Use ThemedText widgets** for most text elements
2. **Choose appropriate text types** based on content hierarchy
3. **Maintain consistency** across similar UI elements
4. **Test with all themes** to ensure readability
5. **Use accent colors sparingly** for maximum impact
6. **Consider accessibility** with sufficient color contrast

This system ensures your app's text always looks great and maintains proper hierarchy across all four themes!