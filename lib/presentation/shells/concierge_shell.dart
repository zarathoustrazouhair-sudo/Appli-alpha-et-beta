import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConciergeShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ConciergeShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.task), label: 'Tâches'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
