import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:residence_lamandier_b/core/security/role_guards.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_screen.dart';
import 'package:residence_lamandier_b/presentation/shells/concierge_shell.dart';
import 'package:residence_lamandier_b/presentation/shells/resident_shell.dart';
import 'package:residence_lamandier_b/presentation/shells/syndic_shell.dart';

// Role Provider (Mocked for now, but ready for Auth integration)
final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.syndic);

final appRouterProvider = Provider<GoRouter>((ref) {
  final role = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WizardScreen(),
        redirect: (context, state) {
           // Simulate "Logged In" check
           // In real app, check Supabase session
           // For demo, if we are at root, redirect based on role
           if (state.uri.toString() == '/') {
             switch (role) {
               case UserRole.syndic:
               case UserRole.adjoint:
                 return '/syndic';
               case UserRole.resident:
                 return '/resident';
               case UserRole.concierge:
                 return '/concierge';
               default:
                 return null;
             }
           }
           return null;
        }
      ),
      GoRoute(
        path: '/syndic',
        builder: (context, state) {
          if (!RoleGuards.canViewAllIncidents(role)) { // Basic check
             return const Scaffold(body: Center(child: Text("Access Denied")));
          }
          return const SyndicShell();
        },
      ),
      GoRoute(
        path: '/resident',
        builder: (context, state) {
          if (role != UserRole.resident && role != UserRole.syndic) {
             return const Scaffold(body: Center(child: Text("Access Denied")));
          }
          return const ResidentShell();
        },
      ),
      GoRoute(
        path: '/concierge',
        builder: (context, state) => const ConciergeShell(),
      ),
    ],
  );
});
