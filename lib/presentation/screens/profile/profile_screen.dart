import 'package:flutter/material.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings functionality
            },
          ),
        ],
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