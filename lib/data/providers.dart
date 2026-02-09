import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'db/app_db.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(DatabaseRef ref) {
  return AppDatabase();
}
