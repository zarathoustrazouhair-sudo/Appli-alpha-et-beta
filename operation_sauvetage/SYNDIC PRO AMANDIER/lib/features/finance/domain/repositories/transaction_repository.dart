import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionsByResident(String residentId);
  Future<void> addTransaction(Transaction transaction);
}
