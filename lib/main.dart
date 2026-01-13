import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quote_vault/core/theme/theme_provider.dart';
import 'package:quote_vault/core/constants/app_constants.dart';
import 'package:quote_vault/app/routes/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/di/injection_container.dart' as di;
import 'presentation/bloc/auth/auth_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mjemndjxpbeouuoomdpw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1qZW1uZGp4cGJlb3V1b29tZHB3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgyNDI2ODYsImV4cCI6MjA4MzgxODY4Nn0.MQBSeQxUAXjnusl7Xb3WgIpP8UFg5Y8BV_qBXyt9c6w',
  );
  
  // Initialize dependency injection
  await di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: AppConstants.appName,
            theme: themeProvider.themeData,
            routerConfig: AppRoutes.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}


