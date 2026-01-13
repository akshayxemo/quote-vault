import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/navigation/bottom_nav_bar.dart';

/// Main shell that contains the persistent bottom navigation
/// Child screens use their own Scaffold - this is the standard pattern for shell routes
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
      body: child, // Child screens provide their own Scaffold with AppBar
      bottomNavigationBar: shouldShowBottomNav 
          ? BottomNavBar(
              currentIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
            )
          : null,
    );
  }
}