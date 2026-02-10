import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/repositories/resident_repository.dart';
import '../../../../data/models/resident.dart';

part 'residents_controller.g.dart';

@riverpod
class ResidentsList extends _$ResidentsList {
  @override
  Stream<List<Resident>> build() {
    final repository = ref.watch(residentRepositoryProvider);
    return repository.watchAllResidents();
  }

  Future<void> addResident(Resident resident) async {
    final repository = ref.read(residentRepositoryProvider);
    await repository.addResident(
      resident.name,
      resident.building,
      resident.apartment,
      resident.phone,
      resident.monthlyFee,
      resident.floor,
    );
  }

  Future<void> updateResident(Resident resident) async {
    final repository = ref.read(residentRepositoryProvider);
    await repository.updateResident(resident);
  }

  Future<void> deleteResident(int id) async {
    final repository = ref.read(residentRepositoryProvider);
    await repository.deleteResident(id);
  }
}

// Balance Provider (Family)
@riverpod
Stream<double> residentBalance(ResidentBalanceRef ref, Resident resident) {
  final repository = ref.watch(residentRepositoryProvider);
  return repository.getResidentBalance(resident);
}
