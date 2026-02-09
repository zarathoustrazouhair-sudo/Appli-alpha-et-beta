import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../db/app_db.dart';
import '../providers.dart';

part 'settings_repo.g.dart';

@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return SettingsRepository(db);
}

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  Future<String?> getResidenceName() async {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('residence_name'));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  Stream<String?> watchResidenceName() {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('residence_name'));
    return query.watchSingleOrNull().map((event) => event?.value);
  }

  Future<void> setResidenceName(String name) async {
    await _db.into(_db.settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: const Value('residence_name'),
        value: Value(name),
      ),
    );
  }

  Future<String?> getLogoPath() async {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('logo_path'));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  Stream<String?> watchLogoPath() {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('logo_path'));
    return query.watchSingleOrNull().map((event) => event?.value);
  }

  Future<void> setLogoPath(String path) async {
    await _db.into(_db.settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: const Value('logo_path'),
        value: Value(path),
      ),
    );
  }
}
