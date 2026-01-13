import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/navigation/app_scaffold.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    
    return AppScaffold(
      currentNavIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            ThemedText.heading('Search Quotes'),
            SizedBox(height: 8),
            ThemedText.body(
              'Search through thousands of inspiring quotes',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}