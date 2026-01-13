# Quote Vault - Lib Folder Structure

This document outlines the organized folder structure for the Quote Vault Flutter application.

## 📁 Folder Structure

```
lib/
├── core/                           # Core functionality and shared resources
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart      # General app constants
│   ├── theme/                      # Theme-related files
│   │   ├── app_colors.dart         # Color definitions for all themes
│   │   ├── app_themes.dart         # Theme configurations
│   │   └── theme_provider.dart     # Theme state management
│   └── utils/                      # Utility functions
│       └── theme_utils.dart        # Theme-related utilities
├── presentation/                   # UI layer
│   ├── screens/                    # App screens
│   │   └── home_screen.dart        # Main home screen
│   └── widgets/                    # Reusable widgets
│       ├── common/                 # Common widgets used across the app
│       │   ├── custom_card.dart    # Custom card widget
│       │   └── theme_preview_card.dart # Theme preview widget
│       └── theme_selector_widget.dart  # Theme selection bottom sheet
└── main.dart                       # App entry point
```

## 🎨 Available Themes

The app includes 4 beautiful themes:

### 1. Minimalist Warm (Default)
- **Primary**: Charcoal (#2D2D2D)
- **Background**: Cream (#FDFCF8)
- **Style**: Clean and warm aesthetic

### 2. Deep Midnight (Dark Theme)
- **Primary**: Soft Silver (#E0E0E0)
- **Background**: Dark Navy (#0B0E14)
- **Style**: Deep and elegant dark theme

### 3. Earthy Sage
- **Primary**: Deep Forest (#1B261D)
- **Background**: Muted Sage (#EDF1E4)
- **Style**: Natural and calming earth tones

### 4. Soft Terracotta
- **Primary**: Rich Umber (#4A2C2A)
- **Background**: Dusty Rose (#F4EAE6)
- **Style**: Warm and cozy terracotta palette

## 🔧 Key Features

- **Theme Provider**: Uses Provider pattern for state management
- **Dynamic Theme Switching**: Switch themes at runtime
- **Consistent Styling**: All themes follow Material 3 design principles
- **Custom Widgets**: Reusable components that adapt to current theme
- **Theme Persistence**: Ready for theme preference storage

## 🚀 Usage

1. **Switching Themes**: Tap the palette icon in the app bar or use the "Switch Theme" button
2. **Theme Selection**: Use the bottom sheet theme selector for detailed theme preview
3. **Custom Widgets**: Use `CustomCard` and other common widgets for consistent theming

## 📱 Architecture

- **Core Layer**: Contains business logic, constants, and utilities
- **Presentation Layer**: Contains UI components, screens, and widgets
- **Provider Pattern**: Used for theme state management
- **Material 3**: All themes are built using Material 3 design system