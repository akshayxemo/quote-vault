import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/theme_selector_widget.dart';
import 'theme_demo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              _showThemeSelector(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(AppConstants.mediumSpacing),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.largeSpacing),
                child: Column(
                  children: [
                    Text(
                      'Current Theme: ${themeProvider.themeName}',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.mediumSpacing),
                    const Text(
                      'You have pushed the button this many times:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: AppConstants.smallSpacing),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConstants.largeSpacing),
            ElevatedButton(
              onPressed: themeProvider.toggleTheme,
              child: const Text('Switch Theme'),
            ),
            const SizedBox(height: AppConstants.mediumSpacing),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThemeDemoScreen(),
                  ),
                );
              },
              child: const Text('View Theme Demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeSelectorWidget(),
    );
  }
}