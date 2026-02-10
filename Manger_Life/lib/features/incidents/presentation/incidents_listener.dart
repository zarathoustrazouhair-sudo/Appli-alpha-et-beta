import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/incident_repository.dart';
import '../domain/incident_model.dart';

// Create a stream provider for listening
final incidentsStreamProvider = StreamProvider.autoDispose<List<IncidentModel>>(
  (ref) {
    final repo = ref.watch(incidentRepositoryProvider);
    return repo.watchIncidents();
  },
);

class IncidentsListener extends ConsumerStatefulWidget {
  final Widget child;
  const IncidentsListener({super.key, required this.child});

  @override
  ConsumerState<IncidentsListener> createState() => _IncidentsListenerState();
}

class _IncidentsListenerState extends ConsumerState<IncidentsListener> {
  final AudioPlayer _player = AudioPlayer();
  int? _lastUrgentId;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAlarm() async {
    try {
      // Using a standard alarm sound URL. In production, this should be a local asset.
      await _player.play(
        UrlSource(
          'https://assets.mixkit.co/active_storage/sfx/995/995-preview.mp3',
        ),
      );
    } catch (e) {
      debugPrint("Audio Error: $e");
    }
  }

  void _showUrgentDialog(IncidentModel incident) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.red[900],
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.white, size: 40),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "ALERTE URGENCE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              incident.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Appartement: ${incident.aptNumber}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Phone: ${incident.residentPhone}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Vérifiez immédiatement !",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _player.stop();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
            ),
            child: const Text("STOP ALARME"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen for changes
    ref.listen(incidentsStreamProvider, (previous, next) {
      next.whenData((incidents) {
        // Find newest urgent incident that is NOT done
        final urgent = incidents.where((i) => i.isUrgent && !i.isDone).toList()
          ..sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
          ); // Sort by newest

        if (urgent.isNotEmpty) {
          final latest = urgent.first;
          // Only trigger if it's a NEW incident ID we haven't alerted for yet
          if (latest.id != _lastUrgentId) {
            _lastUrgentId = latest.id;
            _playAlarm();
            _showUrgentDialog(latest);
          }
        }
      });
    });

    return widget.child;
  }
}
