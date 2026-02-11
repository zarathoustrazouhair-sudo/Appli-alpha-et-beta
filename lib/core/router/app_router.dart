import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:residence_lamandier_b/core/security/role_guards.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_screen.dart';
import 'package:residence_lamandier_b/presentation/main_layout_screen.dart';

// Placeholder for Role Provider
final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.syndic);

final appRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/syndic', // Default for now
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WizardScreen(),
      ),
      GoRoute(
        path: '/syndic',
        builder: (context, state) => const MainLayoutScreen(),
      ),
      // Add other routes here (Resident, Concierge)
    ],
    redirect: (context, state) {
      // Basic Role Guard Logic
      final isLoggingIn = state.uri.toString() == '/';
      if (!isLoggingIn) return null;

      // Logic to check if setup is done (omitted for brevity)
      // return '/syndic';
      return null;
    },
  );
});
