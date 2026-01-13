
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/presentation/screens/auth/signin_screen.dart';
import 'package:quote_vault/presentation/screens/splash/splash_screen.dart';
import 'package:quote_vault/presentation/screens/home_screen.dart';
import 'package:quote_vault/presentation/screens/theme_demo_screen.dart';
import 'package:quote_vault/presentation/screens/auth/signup_screen.dart';
import 'package:quote_vault/presentation/screens/quotes/quotes_screen.dart';
import 'package:quote_vault/presentation/screens/favorites/favorites_screen.dart';
import 'package:quote_vault/presentation/screens/search/search_screen.dart';
import 'package:quote_vault/presentation/screens/profile/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String quotes = '/quotes';
  static const String favorites = '/favorites';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String themeDemo = '/theme-demo';
  static const String signUp = '/signup';
  static const String signIn = '/signin';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: quotes,
        name: 'quotes',
        builder: (context, state) => const QuotesScreen(),
      ),
      GoRoute(
        path: favorites,
        name: 'favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: search,
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: themeDemo,
        name: 'theme-demo',
        builder: (context, state) => const ThemeDemoScreen(),
      ),
      GoRoute(
        path: signUp,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: signIn,
        name: 'signin',
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );

  // Navigation helper methods using go_router
  static void navigateToHome(BuildContext context) {
    context.go(home);
  }

  static void navigateToQuotes(BuildContext context) {
    context.go(quotes);
  }

  static void navigateToFavorites(BuildContext context) {
    context.go(favorites);
  }

  static void navigateToSearch(BuildContext context) {
    context.go(search);
  }

  static void navigateToProfile(BuildContext context) {
    context.go(profile);
  }

  static void navigateToThemeDemo(BuildContext context) {
    context.push(themeDemo);
  }

  static void navigateToSplash(BuildContext context) {
    context.go(splash);
  }

  static void navigateToSignUp(BuildContext context) {
    context.go(signUp);
  }

  static void navigateToSignIn(BuildContext context) {
    context.go(signIn);
  }
}