import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meetings_controller.dart';
import 'create_meeting_screen.dart';
import 'meeting_live_screen.dart';

class MeetingListScreen extends ConsumerWidget {
  const MeetingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingsAsync = ref.watch(meetingsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Assemblées Générales')),
      body: meetingsAsync.when(
        data: (meetings) {
          if (meetings.isEmpty)
            return const Center(child: Text('Aucune AG planifiée.'));
          return ListView.builder(
            itemCount: meetings.length,
            itemBuilder: (context, index) {
              final meeting = meetings[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('AG du ${meeting.date.toString().split(' ')[0]}'),
                  subtitle: Text(meeting.location),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MeetingLiveScreen(meeting: meeting),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateMeetingScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
