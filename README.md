# Quote Vault 📖

A beautiful Flutter application for discovering, saving, and sharing inspirational quotes. Built with clean architecture, BLoC pattern, and Supabase backend.

## ✨ Features

- **Quote of the Day**: Daily curated inspirational quotes
- **Category Browsing**: Explore quotes by different categories
- **Search Functionality**: Search quotes by text or author
- **Favorites**: Save your favorite quotes (requires authentication)
- **User Authentication**: Sign up/Sign in with email
- **Offline Detection**: Graceful handling of network connectivity
- **Infinite Scroll**: Seamless loading of more quotes
- **Share Quotes**: Share quotes as beautiful images
- **Theme Support**: Light and dark theme support

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                 # Core utilities, constants, DI
│   ├── constants/       # App-wide constants
│   ├── di/             # Dependency injection setup
│   ├── error/          # Error handling
│   ├── network/        # Network utilities
│   └── theme/          # Theme configuration
├── data/                # Data layer
│   ├── datasources/    # Remote data sources (Supabase)
│   ├── models/         # Data models
│   └── repositories/   # Repository implementations
├── domain/              # Domain layer
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces
│   └── usecases/       # Business logic use cases
└── presentation/        # Presentation layer
    ├── bloc/           # BLoC state management
    ├── screens/        # UI screens
    └── widgets/        # Reusable widgets
```

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- FVM (Flutter Version Management) - recommended
- Supabase account

### 1. Clone the Repository

```bash
git clone <repository-url>
cd quote_vault
```

### 2. Install FVM (Optional but Recommended)

```bash
# Install FVM globally
dart pub global activate fvm

# Use FVM to install Flutter version
fvm install
fvm use
```

### 3. Install Dependencies

```bash
# If using FVM
fvm flutter pub get

# Without FVM
flutter pub get
```

### 4. Supabase Configuration

#### Create Supabase Project

1. Go to [Supabase](https://supabase.com) and create a new project
2. Note your project URL and anon key

#### Database Schema

Run the following SQL in your Supabase SQL Editor:

```sql
-- Categories table
CREATE TABLE public.categories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT categories_pkey PRIMARY KEY (id)
);

-- Quotes table
CREATE TABLE public.quotes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  quote text,
  author text,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT quotes_pkey PRIMARY KEY (id)
);

-- Quote categories junction table
CREATE TABLE public.quote_categories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  quote_id uuid,
  category_id uuid,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT quote_categories_pkey PRIMARY KEY (id),
  CONSTRAINT quote_categories_quote_id_fkey FOREIGN KEY (quote_id) 
    REFERENCES public.quotes(id),
  CONSTRAINT quote_categories_category_id_fkey FOREIGN KEY (category_id) 
    REFERENCES public.categories(id)
);

-- Quote of the day table
CREATE TABLE public.quote_of_the_day (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  quote_id uuid,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  date date NOT NULL,
  CONSTRAINT quote_of_the_day_pkey PRIMARY KEY (id),
  CONSTRAINT quote_of_the_day_quote_id_fkey FOREIGN KEY (quote_id) 
    REFERENCES public.quotes(id)
);

-- Favorite quotes table
CREATE TABLE public.favorite_quotes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  quote_id uuid,
  user_id uuid,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT favorite_quotes_pkey PRIMARY KEY (id),
  CONSTRAINT favorite_quotes_user_id_fkey FOREIGN KEY (user_id) 
    REFERENCES auth.users(id),
  CONSTRAINT favorite_quotes_quote_id_fkey FOREIGN KEY (quote_id) 
    REFERENCES public.quotes(id)
);

-- Enable Row Level Security
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quote_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quote_of_the_day ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorite_quotes ENABLE ROW LEVEL SECURITY;

-- RLS Policies for public read access
CREATE POLICY "Public read access" ON public.categories FOR SELECT USING (true);
CREATE POLICY "Public read access" ON public.quotes FOR SELECT USING (true);
CREATE POLICY "Public read access" ON public.quote_categories FOR SELECT USING (true);
CREATE POLICY "Public read access" ON public.quote_of_the_day FOR SELECT USING (true);

-- RLS Policies for favorite_quotes
CREATE POLICY "Users can view their own favorites" ON public.favorite_quotes 
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own favorites" ON public.favorite_quotes 
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can delete their own favorites" ON public.favorite_quotes 
  FOR DELETE USING (auth.uid() = user_id);
```

#### Configure App

Create a file `lib/core/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
}
```

**Important**: Add this file to `.gitignore` to keep your credentials secure.

### 5. Run the App

```bash
# If using FVM
fvm flutter run

# Without FVM
flutter run
```

## 🤖 AI Coding Approach & Workflow

### Development Methodology

This project was built using **AI-assisted development** with a structured approach:

1. **Clean Architecture First**: Established clear separation between domain, data, and presentation layers
2. **BLoC Pattern**: Implemented state management using flutter_bloc for predictable state handling
3. **Dependency Injection**: Used GetIt for loose coupling and testability
4. **Iterative Development**: Built features incrementally with continuous testing
5. **Error Handling**: Implemented comprehensive error handling with Either pattern (dartz)

### AI Tools Used

- **Kiro AI**: Primary AI coding assistant for:
  - Code generation and refactoring
  - Architecture design and implementation
  - Bug fixing and debugging
  - Code review and optimization
  - Documentation generation

### Development Workflow

1. **Feature Planning**: Define requirements and architecture
2. **Domain Layer**: Create entities, repository interfaces, and use cases
3. **Data Layer**: Implement repositories and data sources
4. **Presentation Layer**: Build UI with BLoC state management
5. **Dependency Injection**: Register all dependencies
6. **Testing**: Manual testing and bug fixes
7. **Refinement**: Code optimization and cleanup

## 🎨 Design Resources

- **Figma Design**: [Link to Figma design file]
- **Stitch Design**: [Link to Stitch design]

*Note: Add your actual design links here*

## 📦 Key Dependencies

- **supabase_flutter**: Backend as a Service
- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **dartz**: Functional programming (Either, Option)
- **go_router**: Navigation
- **google_fonts**: Custom fonts
- **connectivity_plus**: Network status detection
- **share_plus**: Share functionality
- **gal**: Gallery access for saving images

## ⚠️ Known Limitations & Incomplete Features

### Current Limitations

1. **Image Generation**: Quote sharing as images is implemented but may need optimization
2. **Offline Mode**: App detects offline status but doesn't cache quotes locally
3. **Search Optimization**: Search is functional but could benefit from debouncing
4. **Profile Management**: User profile editing is not yet implemented
5. **Quote Submission**: Users cannot submit their own quotes yet

### Incomplete Features

- [ ] Local caching for offline access
- [ ] User profile customization
- [ ] Quote submission by users
- [ ] Social sharing to specific platforms
- [ ] Quote collections/folders
- [ ] Advanced search filters
- [ ] Quote statistics and analytics
- [ ] Push notifications for daily quotes
- [ ] Multi-language support

### Known Issues

- Print statements in production code (linting warnings)
- Empty catch blocks in some BLoC error handlers
- Favorite status may need manual refresh after toggling in some edge cases


## 📱 Build for Production

### Android

```bash
fvm flutter build apk --release
# or
fvm flutter build appbundle --release
```

### iOS

```bash
fvm flutter build ios --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Developer

Built with ❤️ using Flutter and AI assistance

---

**Note**: Remember to add your Supabase credentials and keep them secure. Never commit sensitive information to version control.
