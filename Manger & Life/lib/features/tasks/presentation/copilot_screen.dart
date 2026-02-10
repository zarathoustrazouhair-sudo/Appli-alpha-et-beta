import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/database/database.dart' hide Provider; // Hide Provider
import '../../tasks/data/task_repository.dart';

// Const Color for Low RAM usage
const Color kCardColor = Color(0xFF1E1E1E);
const Color kGoldColor = Color(0xFFD4AF37);

class CopilotScreen extends ConsumerWidget {
  const CopilotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksStream);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'SYNDIC COPILOT',
          style: TextStyle(
            letterSpacing: 1.5,
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Toutes les tâches sont terminées.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _generateAutoTasks(context, ref),
                    child: const Text('Générer Tâches Mensuelles'),
                  ),
                ],
              ),
            );
          }

          // Group Tasks
          final today = DateTime.now();
          final overdue = <Task>[];
          final current = <Task>[];
          final future = <Task>[];

          for (var t in tasks) {
            if (t.isDone) continue;

            final due = t.dueDate;
            if (due.isBefore(DateTime(today.year, today.month, today.day))) {
              overdue.add(t);
            } else if (due.year == today.year &&
                due.month == today.month &&
                due.day == today.day) {
              current.add(t);
            } else {
              future.add(t);
            }
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (overdue.isNotEmpty) ...[
                const _SectionHeader(title: 'EN RETARD', color: Colors.red),
                ...overdue.map((t) => _TaskTile(task: t)),
                const SizedBox(height: 16),
              ],

              const _SectionHeader(title: 'AUJOURD\'HUI', color: kGoldColor),
              if (current.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Aucune tâche pour aujourd\'hui.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ...current.map((t) => _TaskTile(task: t)),
              const SizedBox(height: 16),

              if (future.isNotEmpty) ...[
                const _SectionHeader(title: 'FUTUR', color: Colors.blueGrey),
                ...future.map((t) => _TaskTile(task: t)),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Erreur: $e', style: const TextStyle(color: Colors.red)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kGoldColor,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () => _showAddTaskDialog(context, ref),
      ),
    );
  }

  Future<void> _generateAutoTasks(BuildContext context, WidgetRef ref) async {
    await ref.read(taskRepositoryProvider).autoGenerateTasks();
    if (context.mounted)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tâches générées')));
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final titleCtrl = TextEditingController();
    DateTime date = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: kCardColor,
          title: const Text(
            'Nouvelle Tâche',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  "Date: ${date.toString().split(' ')[0]}",
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.calendar_today, color: kGoldColor),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 365),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => date = picked);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kGoldColor,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                if (titleCtrl.text.isNotEmpty) {
                  ref
                      .read(taskRepositoryProvider)
                      .addTask(titleCtrl.text, date);
                  Navigator.pop(context);
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _TaskTile extends ConsumerWidget {
  final Task task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: kCardColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        activeColor: kGoldColor,
        checkColor: Colors.black,
        title: Text(
          task.title,
          style: TextStyle(
            color: task.isDone ? Colors.grey : Colors.white,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          task.dueDate.toString().split(' ')[0],
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        value: task.isDone,
        onChanged: (val) {
          ref.read(taskRepositoryProvider).toggleTask(task);
        },
      ),
    );
  }
}
