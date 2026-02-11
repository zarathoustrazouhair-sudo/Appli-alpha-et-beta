import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class CalculateBalanceUseCase {
  final TransactionRepository repository;

  CalculateBalanceUseCase(this.repository);

  Future<double> execute(String residentId) async {
    final transactions = await repository.getTransactionsByResident(residentId);
    double balance = 0.0;
    for (var t in transactions) {
      if (t.type == TransactionType.credit) {
        balance += t.amount;
      } else {
        balance -= t.amount;
      }
    }
    return balance;
  }
}
