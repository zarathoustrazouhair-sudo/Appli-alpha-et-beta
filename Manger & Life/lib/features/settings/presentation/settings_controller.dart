import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/app_config_repository.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<Map<String, String>> build() async {
    final repository = ref.watch(appConfigRepositoryProvider);
    final localConfig = await repository.getAllConfigs();

    // Fetch Remote Config (RIB) if available and merge
    try {
      final supabase = Supabase.instance.client;
      // Assuming 'app_config' table in Supabase has key/value
      final response = await supabase.from('app_config').select();
      for (var row in response) {
        if (row['key'] == 'RIB') {
          localConfig['RIB'] = row['value'];
        }
      }
    } catch (e) {
      // Ignore remote errors, stick to local
    }

    return localConfig;
  }

  Future<void> updateConfig(String key, String value) async {
    final repository = ref.read(appConfigRepositoryProvider);
    await repository.updateConfig(key, value);
    ref.invalidateSelf();
  }
}
