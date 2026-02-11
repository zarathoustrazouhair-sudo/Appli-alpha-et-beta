import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SyndicShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const SyndicShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Cockpit'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Résidents'),
          NavigationDestination(icon: Icon(Icons.attach_money), label: 'Finance'),
          NavigationDestination(icon: Icon(Icons.folder), label: 'Documents'),
          NavigationDestination(icon: Icon(Icons.article), label: 'Blog'),
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
