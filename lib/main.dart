import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/core/settings/text_size_provider.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/app/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/auth/auth_event.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mjemndjxpbeouuoomdpw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qZW1uZGp4cGJlb3V1b29tZHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgyNDI2ODYsImV4cCI6MjA4MzgxODY4Nn0.MQBSeQxUAXjnusl7Xb3WgIpP8UFg5Y8BV_qBXyt9c6w',
  );
  
  // Initialize dependency injection
  await di.init();
  
  // Initialize SharedPreferences for TextSizeProvider
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TextSizeProvider(prefs)),
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()
            ..add(const CheckSessionEvent()),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: AppConstants.appName,
            theme: themeProvider.themeData,
            darkTheme: themeProvider.darkThemeData,
            themeMode: themeProvider.currentThemeMode,
            routerConfig: AppRoutes.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}


