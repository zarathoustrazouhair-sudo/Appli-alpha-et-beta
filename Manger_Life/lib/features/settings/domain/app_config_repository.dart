import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/database/database.dart';
import '../../../data/database/database_provider.dart';

part 'app_config_repository.g.dart';

@riverpod
AppConfigRepository appConfigRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return AppConfigRepository(db);
}

class AppConfigRepository {
  final AppDatabase _db;
  AppConfigRepository(this._db);

  Future<Map<String, String>> getAllConfigs() async {
    final rows = await _db.select(_db.appConfigs).get();
    return {for (var r in rows) r.key: r.value};
  }

  Future<String?> getConfig(String key) async {
    final row = await (_db.select(
      _db.appConfigs,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> updateConfig(String key, String value) {
    return _db
        .into(_db.appConfigs)
        .insertOnConflictUpdate(
          AppConfigsCompanion(key: drift.Value(key), value: drift.Value(value)),
        );
  }
}
