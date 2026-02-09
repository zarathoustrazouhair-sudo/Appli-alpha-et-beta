import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  static const String _rootPathKey = 'root_folder_path';

  SettingsRepository(this._db);

  Stream<String?> watchResidenceName() {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('residence_name'));
    return query.watchSingleOrNull().map((event) => event?.value);
  }

  Future<String?> getResidenceName() async {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('residence_name'));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  Future<void> setResidenceName(String name) async {
    await _db.into(_db.settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: const Value('residence_name'),
        value: Value(name),
      ),
    );
  }

  Stream<String?> watchLogoPath() {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('logo_path'));
    return query.watchSingleOrNull().map((event) => event?.value);
  }

  Future<String?> getLogoPath() async {
    final query = _db.select(_db.settings)..where((tbl) => tbl.key.equals('logo_path'));
    final result = await query.getSingleOrNull();
    return result?.value;
  }

  Future<void> setLogoPath(String path) async {
    await _db.into(_db.settings).insertOnConflictUpdate(
      SettingsCompanion(
        key: const Value('logo_path'),
        value: Value(path),
      ),
    );
  }

  // Root Folder Path (SharedPreferences)
  Future<String?> getRootFolderPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rootPathKey);
  }

  Future<void> setRootFolderPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_rootPathKey, path);
  }
}
