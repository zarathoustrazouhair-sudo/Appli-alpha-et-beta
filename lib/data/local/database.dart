import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:residence_lamandier_b/core/sync/mutation_queue_entity.dart';
import 'package:residence_lamandier_b/features/tasks/data/task_entity.dart';
import 'package:residence_lamandier_b/features/users/data/user_entity.dart';
import 'package:residence_lamandier_b/features/settings/data/app_settings_entity.dart';
import 'package:residence_lamandier_b/core/constants/initial_data.dart';

part 'database.g.dart';

@DriftDatabase(tables: [MutationQueue, Tasks, Users, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      if (details.wasCreated) {
        await _populateInitialData();
      }
    },
  );

  Future<void> _populateInitialData() async {
    await batch((batch) {
      // 1. Insert Residents
      for (final resident in kInitialResidents) {
        batch.insert(
          users,
          UsersCompanion.insert(
            name: resident.name,
            floor: Value(resident.floor),
            apartmentNumber: Value(resident.aptNumber),
            role: Value(resident.role),
          ),
        );
      }

      // 2. Insert Staff
      // Adjoint
      batch.insert(
        users,
        UsersCompanion.insert(
          id: Value(100),
          name: kAdjointName,
          role: Value('adjoint'),
        ),
      );
      // Concierge
      batch.insert(
        users,
        UsersCompanion.insert(
          id: Value(101),
          name: "Gardien Principal",
          role: Value('concierge'),
        ),
      );
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
