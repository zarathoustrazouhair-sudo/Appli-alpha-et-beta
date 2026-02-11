import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/database.dart';
import '../security/role_guards.dart';
import '../../presentation/shells/syndic_shell.dart';
import '../../presentation/shells/resident_shell.dart';
import '../../presentation/shells/concierge_shell.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/cockpit_screen.dart';
import '../../presentation/screens/concierge_tasks_screen.dart';
import '../../features/resident_home/presentation/my_apartment_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final userRole = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.uri.path == '/login';

      // Redirect to appropriate home if already logged in (simulated by having a role)
      if (isLoggingIn) {
        if (RoleGuards.isSyndicOrAdmin(userRole)) return '/syndic/cockpit';
        if (RoleGuards.isResident(userRole)) return '/resident/home';
        if (RoleGuards.isConcierge(userRole)) return '/concierge/tasks';
      }

      // Guard Routes
      if (state.uri.path.startsWith('/syndic') && !RoleGuards.isSyndicOrAdmin(userRole)) {
        return '/login';
      }
      if (state.uri.path.startsWith('/resident') && !RoleGuards.isResident(userRole)) {
        return '/login';
      }
      if (state.uri.path.startsWith('/concierge') && !RoleGuards.isConcierge(userRole)) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Syndic Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => SyndicShell(navigationShell: navigationShell),
        branches: [
           StatefulShellBranch(routes: [GoRoute(path: '/syndic/cockpit', builder: (context, state) => const CockpitScreen())]),
           StatefulShellBranch(routes: [GoRoute(path: '/syndic/residents', builder: (context, state) => const Scaffold(body: Center(child: Text('Résidents'))))]),
           StatefulShellBranch(routes: [GoRoute(path: '/syndic/finance', builder: (context, state) => const Scaffold(body: Center(child: Text('Finance'))))]),
           StatefulShellBranch(routes: [GoRoute(path: '/syndic/documents', builder: (context, state) => const Scaffold(body: Center(child: Text('Documents'))))]),
           StatefulShellBranch(routes: [GoRoute(path: '/syndic/blog', builder: (context, state) => const Scaffold(body: Center(child: Text('Blog'))))]),
        ],
      ),

      // Resident Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ResidentShell(navigationShell: navigationShell),
        branches: [
           StatefulShellBranch(routes: [GoRoute(path: '/resident/home', builder: (context, state) => const MyApartmentScreen())]),
           StatefulShellBranch(routes: [GoRoute(path: '/resident/settings', builder: (context, state) => const Scaffold(body: Center(child: Text('Paramètres'))))]),
        ],
      ),

      // Concierge Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ConciergeShell(navigationShell: navigationShell),
        branches: [
           StatefulShellBranch(routes: [GoRoute(path: '/concierge/tasks', builder: (context, state) => const ConciergeTasksScreen())]),
           StatefulShellBranch(routes: [GoRoute(path: '/concierge/profile', builder: (context, state) => const Scaffold(body: Center(child: Text('Profil'))))]),
        ],
      ),
    ],
  );
});
