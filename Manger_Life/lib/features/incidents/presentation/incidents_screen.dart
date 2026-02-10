import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../incidents/data/incident_repository.dart';

class IncidentsScreen extends ConsumerWidget {
  const IncidentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incidentsAsync = ref
        .watch(incidentRepositoryProvider)
        .watchIncidents();

    return Scaffold(
      appBar: AppBar(title: const Text('Incidents (Cloud)')),
      body: StreamBuilder(
        stream: incidentsAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          final incidents = snapshot.data ?? [];
          if (incidents.isEmpty) {
            return const Center(child: Text('Aucun incident signalé.'));
          }

          return ListView.builder(
            itemCount: incidents.length,
            itemBuilder: (context, index) {
              final incident = incidents[index];
              return Card(
                color: const Color(0xFF1E1E1E),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: incident.isUrgent
                      ? const BorderSide(color: Colors.red, width: 2)
                      : BorderSide.none,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.report_problem,
                    color: incident.isUrgent ? Colors.red : Colors.amber,
                  ),
                  title: Text(
                    incident.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        incident.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        incident.displayName,
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    incident.createdAt.toString().split(' ')[0],
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
