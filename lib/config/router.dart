import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/screens/splash_screen.dart';
import 'package:insurance_app/screens/login_screen.dart';
import 'package:insurance_app/screens/otp_screen.dart';
import 'package:insurance_app/screens/home_screen.dart';
import 'package:insurance_app/screens/policies_screen.dart';
import 'package:insurance_app/screens/policy_detail_screen.dart';
import 'package:insurance_app/screens/claims_screen.dart';
import 'package:insurance_app/screens/insurance_card_screen.dart';
import 'package:insurance_app/screens/support_screen.dart';
import 'package:insurance_app/screens/profile_screen.dart';

/// App navigation configuration
/// Defines all routes and navigation paths in the app
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen - shown first when app opens
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Login screen
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // OTP verification screen
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        return OtpScreen(
          loginMethod: extra?['loginMethod'] ?? '',
          loginValue: extra?['loginValue'] ?? '',
        );
      },
    ),

    // Home screen
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // My Policies screen
    GoRoute(
      path: '/policies',
      builder: (context, state) => const PoliciesScreen(),
    ),

    // Policy Detail screen
    GoRoute(
      path: '/policy/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return PolicyDetailScreen(policyId: id);
      },
    ),

    // My Claims screen
    GoRoute(
      path: '/claims',
      builder: (context, state) => const ClaimsScreen(),
    ),

    // Insurance Card screen
    GoRoute(
      path: '/insurance-card',
      builder: (context, state) => const InsuranceCardScreen(),
    ),

    // Support screen
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportScreen(),
    ),

    // Profile screen
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
