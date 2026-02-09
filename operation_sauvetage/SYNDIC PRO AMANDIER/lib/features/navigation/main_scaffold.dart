import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/dashboard_screen_optimized.dart';
import '../../features/management/presentation/management_tab.dart';
import '../../features/tasks/presentation/copilot_screen.dart';
import '../../features/transactions/presentation/transactions_history_screen.dart';
import '../../features/incidents/presentation/incidents_listener.dart'; // Import Siren
import '../../features/settings/presentation/settings_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreenOptimized(),
    ManagementTab(),
    TransactionsHistoryScreen(),
    CopilotScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return IncidentsListener(
      // Wrap with Siren
      child: Scaffold(
        appBar: _currentIndex == 0
            ? null
            : AppBar(
                // Hide AppBar on Dashboard (it has its own)
                title: const Text('AMANDIER MANAGER'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsFormScreen(),
                      ),
                    ),
                  ),
                ],
              ),
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E1E), // Dark Grey
          selectedItemColor: const Color(0xFFD4AF37), // Gold
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Tableau Bord',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Gestion'),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Finances',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Copilote',
            ),
          ],
        ),
      ),
    );
  }
}
