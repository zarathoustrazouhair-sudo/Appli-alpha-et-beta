import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:residence_lamandier_b/core/router/role_guards.dart';
import 'package:residence_lamandier_b/features/onboarding/presentation/wizard_screen.dart';
import 'package:residence_lamandier_b/presentation/shells/concierge_shell.dart';
import 'package:residence_lamandier_b/presentation/shells/resident_shell.dart';
import 'package:residence_lamandier_b/presentation/shells/syndic_shell.dart';

// Role Provider
// In production, this would come from a secure Auth State (e.g., Supabase Auth + Local DB)
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
           // Basic "Switchboard" Logic
           // Redirects strictly based on role when hitting root
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
          // GUARD: Strict Access Control
          if (role != UserRole.syndic && role != UserRole.adjoint) {
             return const Scaffold(body: Center(child: Text("ACCESS DENIED: SYNDIC AREA")));
          }
          return const SyndicShell();
        },
      ),
      GoRoute(
        path: '/resident',
        builder: (context, state) {
          // GUARD: Strict Access Control
          if (role != UserRole.resident && role != UserRole.syndic) { // Syndic can debug view
             return const Scaffold(body: Center(child: Text("ACCESS DENIED: RESIDENT AREA")));
          }
          return const ResidentShell();
        },
      ),
      GoRoute(
        path: '/concierge',
        builder: (context, state) {
          if (role != UserRole.concierge && role != UserRole.syndic) {
             return const Scaffold(body: Center(child: Text("ACCESS DENIED: CONCIERGE AREA")));
          }
          return const ConciergeShell();
        },
      ),
    ],
  );
});
