import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/navigation/bottom_nav_bar.dart';

/// Main shell that contains the persistent bottom navigation
/// while allowing each route to have its own AppBar
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final shouldShowBottomNav = NavigationHelper.shouldShowBottomNav(currentRoute);
    
    return Scaffold(
      // No AppBar here - each child screen will provide its own
      body: child,
      bottomNavigationBar: shouldShowBottomNav 
          ? BottomNavBar(
              currentIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
            )
          : null,
    );
  }
}