import 'package:flutter/material.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new quote functionality
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.format_quote,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            ThemedText.heading('Quotes Collection'),
            SizedBox(height: 8),
            ThemedText.body(
              'Your curated quotes will appear here',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}