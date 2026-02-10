import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart' hide Provider; // Fix Ambiguity

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
