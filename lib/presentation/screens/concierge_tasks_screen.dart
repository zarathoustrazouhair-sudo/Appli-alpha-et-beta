import 'package:flutter/material.dart';

class ConciergeTasksScreen extends StatelessWidget {
  const ConciergeTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tâches Concierge')),
      body: const Center(child: Text('Liste des tâches...')),
    );
  }
}
