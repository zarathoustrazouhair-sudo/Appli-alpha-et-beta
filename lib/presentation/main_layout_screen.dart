import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:residence_lamandier_b/core/design/app_theme.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/cockpit_screen.dart';

class MainLayoutScreen extends ConsumerStatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  ConsumerState<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends ConsumerState<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CockpitScreen(),
    const Center(child: Text("Résidents", style: TextStyle(color: AppTheme.gold))),
    const Center(child: Text("RH & Prestataires", style: TextStyle(color: AppTheme.gold))),
    const Center(child: Text("Finance", style: TextStyle(color: AppTheme.gold))),
    const Center(child: Text("Documents", style: TextStyle(color: AppTheme.gold))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppTheme.darkNavy,
          selectedItemColor: AppTheme.gold,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'COCKPIT',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'RÉSIDENTS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.engineering_outlined),
              activeIcon: Icon(Icons.engineering),
              label: 'RH & PROS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'FINANCE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_open),
              activeIcon: Icon(Icons.folder),
              label: 'DOCS',
            ),
          ],
        ),
      ),
    );
  }
}
