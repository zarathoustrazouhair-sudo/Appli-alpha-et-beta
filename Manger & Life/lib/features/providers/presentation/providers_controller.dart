import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/provider.dart' as entity;
import '../domain/provider_repository.dart';

part 'providers_controller.g.dart';

@riverpod
class ProvidersList extends _$ProvidersList {
  @override
  FutureOr<List<entity.Provider>> build() async {
    final repository = ref.watch(providerRepositoryProvider);
    return repository.getProviders();
  }

  Future<void> addProvider(String name, String jobType, String phone) async {
    final repository = ref.read(providerRepositoryProvider);
    final provider = entity.Provider(
      id: 0,
      name: name,
      jobType: jobType,
      phone: phone,
    );
    await repository.addProvider(provider);
    ref.invalidateSelf();
  }

  Future<void> deleteProvider(int id) async {
    final repository = ref.read(providerRepositoryProvider);
    await repository.deleteProvider(id);
    ref.invalidateSelf();
  }
}
