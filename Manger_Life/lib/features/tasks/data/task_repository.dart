import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../data/database/database.dart' hide Provider; // Hide Provider
import '../../../../data/database/database_provider.dart'; // Import Provider

// REPOSITORY PROVIDER
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TaskRepository(db);
});

// STREAMS
final tasksStream = StreamProvider<List<Task>>((ref) {
  return ref.watch(taskRepositoryProvider).watchAllTasks();
});

class TaskRepository {
  final AppDatabase _db;
  TaskRepository(this._db);

  Stream<List<Task>> watchAllTasks() {
    return (_db.select(_db.tasks)..orderBy([
          (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.asc),
        ]))
        .watch();
  }

  Future<void> addTask(String title, DateTime dueDate, {int type = 0}) {
    return _db
        .into(_db.tasks)
        .insert(
          TasksCompanion.insert(
            title: title,
            dueDate: dueDate,
            type: Value(type),
            isDone: const Value(false),
          ),
        );
  }

  Future<void> toggleTask(Task task) {
    return (_db.update(_db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(isDone: Value(!task.isDone)),
    );
  }

  Future<void> autoGenerateTasks() async {
    final today = DateTime.now();
    // Removed unused startOfMonth

    if (today.day == 1) {
      await addTask("Vérifier Paiements (Auto)", today, type: 1);
      await addTask(
        "Payer Factures Eau/Elec (Auto)",
        today.add(const Duration(days: 5)),
        type: 1,
      );
    }
  }
}
