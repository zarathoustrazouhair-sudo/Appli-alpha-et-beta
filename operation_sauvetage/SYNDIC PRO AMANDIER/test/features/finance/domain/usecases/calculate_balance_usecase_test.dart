import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/features/finance/domain/entities/transaction.dart';
import 'package:syndic_pro/features/finance/domain/repositories/transaction_repository.dart';
import 'package:syndic_pro/features/finance/domain/usecases/calculate_balance_usecase.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<void> addTransaction(Transaction transaction) async {}

  @override
  Future<List<Transaction>> getTransactionsByResident(String residentId) async {
    if (residentId == "user_credit") {
      return [
        Transaction(
          id: '1',
          residentId: residentId,
          amount: 500.0,
          type: TransactionType.credit,
          date: DateTime.now(),
          description: 'Payment',
        )
      ];
    } else if (residentId == "user_debit") {
      return [
        Transaction(
          id: '2',
          residentId: residentId,
          amount: 250.0,
          type: TransactionType.debit,
          date: DateTime.now(),
          description: 'Fee',
        )
      ];
    } else if (residentId == "user_mixed") {
      return [
        Transaction(
          id: '3',
          residentId: residentId,
          amount: 1000.0,
          type: TransactionType.credit,
          date: DateTime.now(),
          description: 'Payment',
        ),
        Transaction(
          id: '4',
          residentId: residentId,
          amount: 250.0,
          type: TransactionType.debit,
          date: DateTime.now(),
          description: 'Fee',
        ),
      ];
    }
    return [];
  }
}

void main() {
  group('CalculateBalanceUseCase', () {
    late CalculateBalanceUseCase useCase;
    late MockTransactionRepository repository;

    setUp(() {
      repository = MockTransactionRepository();
      useCase = CalculateBalanceUseCase(repository);
    });

    test('returns positive balance for credits', () async {
      final balance = await useCase.execute("user_credit");
      expect(balance, 500.0);
    });

    test('returns negative balance for debits', () async {
      final balance = await useCase.execute("user_debit");
      expect(balance, -250.0);
    });

    test('returns correct net balance', () async {
      final balance = await useCase.execute("user_mixed");
      expect(balance, 750.0); // 1000 - 250
    });
  });
}
