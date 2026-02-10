import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/dashboard_screen_optimized.dart';
import '../../features/management/presentation/management_tab.dart';
import '../../features/tasks/presentation/copilot_screen.dart';
import '../../features/transactions/presentation/transactions_history_screen.dart';
import '../../features/incidents/presentation/incidents_listener.dart'; // Import Siren
import '../../features/settings/presentation/settings_screen.dart';
import '../../core/theme/app_theme.dart'; // Use centralized theme constants

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
        backgroundColor: AppTheme.scaffoldColor,
        // AppBar is handled individually by screens or globally here if needed.
        // Dashboard usually has its own custom header.
        appBar: _currentIndex == 0
            ? null // Dashboard has its own header
            : AppBar(
                title: const Text('AMANDIER MANAGER'),
                backgroundColor: AppTheme.surfaceColor,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                   color: AppTheme.primaryColor,
                   fontWeight: FontWeight.bold,
                   letterSpacing: 1.2,
                   fontSize: 20,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: AppTheme.textSubtitleColor),
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
          backgroundColor: AppTheme.surfaceColor, // Dark Grey from Theme
          selectedItemColor: AppTheme.primaryColor, // Gold from Theme
          unselectedItemColor: AppTheme.textSubtitleColor, // Grey from Theme
          showUnselectedLabels: true,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Tableau Bord',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build_outlined),
              activeIcon: Icon(Icons.build),
              label: 'Gestion',
            ),
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
