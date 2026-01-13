import 'package:flutter/material.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // Sort favorites functionality
            },
          ),
        ],
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