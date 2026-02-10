import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import '../../../../data/database/database.dart';
import '../../../../data/database/database_provider.dart';
import '../../../../data/models/provider.dart' as entity;

part 'provider_repository.g.dart';

@riverpod
ProviderRepository providerRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProviderRepository(db);
}

class ProviderRepository {
  final AppDatabase _db;
  ProviderRepository(this._db);

  Future<List<entity.Provider>> getProviders() async {
    final rows = await (_db.select(
      _db.providers,
    )..orderBy([(t) => drift.OrderingTerm(expression: t.name)])).get();
    return rows
        .map(
          (e) => entity.Provider(
            id: e.id,
            name: e.name,
            jobType: e.jobType,
            phone: e.phone,
          ),
        )
        .toList();
  }

  Future<int> addProvider(entity.Provider provider) {
    return _db
        .into(_db.providers)
        .insert(
          ProvidersCompanion(
            name: drift.Value(provider.name),
            jobType: drift.Value(provider.jobType),
            phone: drift.Value(provider.phone),
          ),
        );
  }

  Future<void> deleteProvider(int id) {
    return (_db.delete(_db.providers)..where((t) => t.id.equals(id))).go();
  }
}
