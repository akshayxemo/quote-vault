
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/presentation/screens/splash/splash_screen.dart';
import 'package:quote_vault/presentation/screens/home_screen.dart';
import 'package:quote_vault/presentation/screens/theme_demo_screen.dart';
import 'package:quote_vault/presentation/screens/auth/signup_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
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
        path: themeDemo,
        name: 'theme-demo',
        builder: (context, state) => const ThemeDemoScreen(),
      ),
      GoRoute(
        path: signUp,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      // TODO: Add SignInScreen
      // GoRoute(
      //   path: signIn,
      //   name: 'signin',
      //   builder: (context, state) => const SignInScreen(),
      // ),
    ],
  );

  // Navigation helper methods using go_router
  static void navigateToHome(BuildContext context) {
    context.go(home);
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