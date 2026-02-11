import 'dart:async';
import '../../../../data/database/database.dart';
import '../entities/resident.dart' as domain;

abstract class ResidentRepository {
  Stream<List<domain.Resident>> watchAllResidents();
  Future<List<domain.Resident>> getResidents();
  Stream<List<Payment>> getPayments(domain.Resident resident);
  Stream<double> getResidentBalance(domain.Resident resident);
  Future<void> addResident(
    String name,
    String building,
    String apartment,
    String phone,
    int monthlyFee,
    int? floor,
  );
  Future<void> updateResident(domain.Resident resident);
  Future<void> deleteResident(int id);
  Future<void> updateAllFees(int newFee);
  Future<void> addPayment(int residentId, double amount, DateTime date);
}
