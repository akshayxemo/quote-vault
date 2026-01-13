import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/navigation/app_scaffold.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    
    return AppScaffold(
      currentNavIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            SizedBox(height: 16),
            ThemedText.heading('Your Profile'),
            SizedBox(height: 8),
            ThemedText.body(
              'Manage your account and preferences',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}