import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/navigation/app_scaffold.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    
    return AppScaffold(
      currentNavIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            ThemedText.heading('Favorite Quotes'),
            SizedBox(height: 8),
            ThemedText.body(
              'Your favorite quotes will be saved here',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}