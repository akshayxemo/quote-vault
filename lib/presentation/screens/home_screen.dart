import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/core/navigation/navigation_helper.dart';
import 'package:quote_vault/presentation/widgets/theme_selector_widget.dart';
import 'package:quote_vault/presentation/widgets/common/themed_text.dart';
import 'package:quote_vault/presentation/widgets/navigation/app_scaffold.dart';

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
    final currentRoute = GoRouterState.of(context).uri.path;
    
    return AppScaffold(
      currentNavIndex: NavigationHelper.getCurrentNavIndex(currentRoute),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: AppConstants.mediumSpacing),
              Card(
                margin: const EdgeInsets.all(AppConstants.mediumSpacing),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.largeSpacing),
                  child: Column(
                    children: [
                      ThemedText.heading(
                        'Current Theme: ${themeProvider.themeName}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      ThemedText.body(
                        'You have pushed the button this many times:',
                      ),
                      const SizedBox(height: AppConstants.smallSpacing),
                      ThemedText.accent(
                        '$_counter',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
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
                  context.push('/theme-demo');
                },
                child: const Text('View Theme Demo'),
              ),
              const SizedBox(height: AppConstants.mediumSpacing),
              ElevatedButton(
                onPressed: () {
                  context.push('/signup');
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: AppConstants.mediumSpacing),
            ],
          ),
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