import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:insurance_app/services/auth_service.dart';
import 'package:insurance_app/config/router.dart';
import 'package:insurance_app/config/theme.dart';

/// Main entry point of the app
/// This sets up the app with providers, routing, and theme
void main() {
  runApp(const InsuranceApp());
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Providers allow us to share data across the app
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp.router(
        title: 'Insurance App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme, // Our custom theme
        routerConfig: appRouter, // Navigation routes
      ),
    );
  }
}
