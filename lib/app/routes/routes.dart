
import 'package:go_router/go_router.dart';
import 'package:quote_vault/presentation/screens/auth/signin_screen.dart';
import 'package:quote_vault/presentation/screens/home/home_screen.dart';
import 'package:quote_vault/presentation/screens/splash/splash_screen.dart';
import 'package:quote_vault/presentation/screens/auth/signup_screen.dart';
import 'package:quote_vault/presentation/screens/favorites/favorites_screen.dart';
import 'package:quote_vault/presentation/screens/search/search_screen.dart';
import 'package:quote_vault/presentation/screens/profile/profile_screen.dart';
import 'package:quote_vault/presentation/widgets/navigation/main_shell.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String collections = '/collections';
  static const String favorites = '/favorites';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String signUp = '/signup';
  static const String signIn = '/signin';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Routes without shell (splash, auth)
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
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
      
      // Shell route for main app navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          // GoRoute(
          //   path: collections,
          //   name: 'collections',
          //   builder: (context, state) => const QuotesScreen(),
          // ),
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
        ],
      ),
    ],
  );
}