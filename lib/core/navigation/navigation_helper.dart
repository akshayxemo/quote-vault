/// Helper class for navigation-related utilities
class NavigationHelper {
  /// Get the current navigation index based on the current route
  static int getCurrentNavIndex(String currentRoute) {
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/quotes':
        return 1;
      case '/favorites':
        return 2;
      case '/search':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0; // Default to home
    }
  }

  /// Get route path from navigation index
  static String getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/quotes';
      case 2:
        return '/favorites';
      case 3:
        return '/search';
      case 4:
        return '/profile';
      default:
        return '/home';
    }
  }

  /// Check if the current route should show bottom navigation
  static bool shouldShowBottomNav(String currentRoute) {
    const routesWithBottomNav = [
      '/home',
      '/quotes',
      '/favorites',
      '/search',
      '/profile',
    ];
    return routesWithBottomNav.contains(currentRoute);
  }

  /// Navigation items configuration
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      index: 0,
      route: '/home',
      label: 'Home',
      icon: 'home_outlined',
      activeIcon: 'home',
    ),
    NavigationItem(
      index: 1,
      route: '/quotes',
      label: 'Quotes',
      icon: 'format_quote_outlined',
      activeIcon: 'format_quote',
    ),
    NavigationItem(
      index: 2,
      route: '/favorites',
      label: 'Favorites',
      icon: 'favorite_outline',
      activeIcon: 'favorite',
    ),
    NavigationItem(
      index: 3,
      route: '/search',
      label: 'Search',
      icon: 'search_outlined',
      activeIcon: 'search',
    ),
    NavigationItem(
      index: 4,
      route: '/profile',
      label: 'Profile',
      icon: 'person_outline',
      activeIcon: 'person',
    ),
  ];
}

/// Navigation item configuration
class NavigationItem {
  final int index;
  final String route;
  final String label;
  final String icon;
  final String activeIcon;

  const NavigationItem({
    required this.index,
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}