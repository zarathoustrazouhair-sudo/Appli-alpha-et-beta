import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:residence_lamandier_b/data/local/database.dart';
import 'package:residence_lamandier_b/core/sync/mutation_queue_entity.dart';
import 'package:drift/drift.dart';

part 'sync_manager.g.dart';

@riverpod
SyncManager syncManager(SyncManagerRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncManager(db);
}

class SyncManager {
  final AppDatabase _db;

  SyncManager(this._db);

  Future<void> enqueueMutation({
    required String type,
    required String payloadJson,
  }) async {
    await _db.into(_db.mutationQueue).insert(
      MutationQueueCompanion.insert(
        type: type,
        payloadJson: payloadJson,
        status: const Value('pending'),
      ),
    );
  }

  Future<void> processQueue() async {
    // Placeholder for actual processing logic
    // Fetch pending items
    final pending = await (_db.select(_db.mutationQueue)
      ..where((tbl) => tbl.status.equals('pending')))
      .get();

    // For now, just print or simulate
    for (var item in pending) {
      // Simulate success
      await (_db.update(_db.mutationQueue)
        ..where((tbl) => tbl.id.equals(item.id)))
        .write(MutationQueueCompanion(
          status: const Value('completed'),
        ));
    }
  }
}
