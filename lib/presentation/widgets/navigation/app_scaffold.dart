import 'package:flutter/material.dart';
import 'package:quote_vault/presentation/widgets/navigation/bottom_nav_bar.dart';

/// Scaffold wrapper with bottom navigation
class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final int currentNavIndex;
  final Function(int)? onNavTap;
  final FloatingActionButton? floatingActionButton;
  final bool showBottomNav;
  final Color? backgroundColor;

  const AppScaffold({
    super.key,
    required this.body,
    required this.currentNavIndex,
    this.appBar,
    this.onNavTap,
    this.floatingActionButton,
    this.showBottomNav = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: showBottomNav 
          ? BottomNavBar(
              currentIndex: currentNavIndex,
              onTap: onNavTap,
            )
          : null,
    );
  }
}