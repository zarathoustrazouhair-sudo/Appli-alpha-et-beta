import 'package:flutter/material.dart';
import '../../residents/presentation/residents_screen.dart';
import '../../incidents/presentation/incidents_screen.dart';
import '../../providers/presentation/providers_screen.dart';
import '../../ag/presentation/ag_screen.dart';
import '../../expenses/presentation/expenses_screen.dart'; // Orphan Fix

class ManagementTab extends StatelessWidget {
  const ManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Increased for Expenses
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestion'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Résidents', icon: Icon(Icons.people)),
              Tab(text: 'Incidents', icon: Icon(Icons.report)),
              Tab(
                text: 'Dépenses',
                icon: Icon(Icons.money_off),
              ), // Reconnected Orphan
              Tab(text: 'Prestataires', icon: Icon(Icons.handyman)),
              Tab(text: 'AG', icon: Icon(Icons.meeting_room)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ResidentsScreen(),
            IncidentsScreen(),
            ExpensesScreen(), // Reconnected Orphan
            ProvidersScreen(),
            AgScreen(),
          ],
        ),
      ),
    );
  }
}
