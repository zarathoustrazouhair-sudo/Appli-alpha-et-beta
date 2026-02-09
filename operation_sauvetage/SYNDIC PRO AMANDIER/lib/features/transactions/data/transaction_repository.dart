import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../data/database/database.dart' hide Provider;
import '../../../../data/database/database_provider.dart';

// REPOSITORY PROVIDER
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TransactionRepository(db);
});

// STREAMS FOR DASHBOARD
final totalClass5Stream = StreamProvider<int>((ref) {
  return ref.watch(transactionRepositoryProvider).watchTotalBalance(5);
});

final totalClass1Stream = StreamProvider<int>((ref) {
  return ref.watch(transactionRepositoryProvider).watchTotalBalance(1);
});

final recentTransactionsStream = StreamProvider<List<Transaction>>((ref) {
  return ref.watch(transactionRepositoryProvider).watchRecentTransactions(5);
});

final accountsStream = StreamProvider<List<Account>>((ref) {
  return ref.watch(transactionRepositoryProvider).watchAllAccounts();
});

class TransactionRepository {
  final AppDatabase _db;
  TransactionRepository(this._db);

  Stream<int> watchTotalBalance(int classCode) {
    final query = _db.select(_db.accounts)
      ..where((tbl) => tbl.classCode.equals(classCode));
    return query.watch().map((accounts) {
      if (accounts.isEmpty) return 0;
      return accounts.map((a) => a.balanceCents).reduce((a, b) => a + b);
    });
  }

  // UPDATED: Try to join with Residents if possible, or just append name to description.
  // The 'Transaction' table is for Double-Entry bookkeeping.
  // The 'Payment' table tracks Resident payments.
  // Usually, a Payment insert triggers a Transaction insert.
  // If we want to see Resident Name in Transaction List, we need to know WHICH resident paid.
  // BUT: Transaction table (debit/credit) doesn't have resident_id.
  // FIX: We can update `watchRecentTransactions` to maybe join with `Payments` table via `proofHash` or timestamp?
  // OR: Just fetch `Transactions` and `Payments` and merge in UI?
  // BETTER: When creating a Payment (Resident History), we create a Transaction with description "Paiement - [Resident Name]".
  // So let's check where Payments are created. -> `ResidentRepository.addPayment`

  Stream<List<Transaction>> watchRecentTransactions(int limit) {
    return (_db.select(_db.transactions)
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .watch();
  }

  Stream<List<Account>> watchAllAccounts() {
    return (_db.select(
      _db.accounts,
    )..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();
  }

  Future<void> addTransaction({
    required int debitAccountId,
    required int creditAccountId,
    required int amountCents,
    required String description,
    required DateTime date,
    String? proofHash,
  }) async {
    return _db.transaction(() async {
      await _db
          .into(_db.transactions)
          .insert(
            TransactionsCompanion.insert(
              debitAccountId: debitAccountId,
              creditAccountId: creditAccountId,
              amountCents: amountCents,
              date: date,
              description: description,
              proofHash: Value(proofHash),
            ),
          );

      final debitAccount = await (_db.select(
        _db.accounts,
      )..where((t) => t.id.equals(debitAccountId))).getSingle();
      final creditAccount = await (_db.select(
        _db.accounts,
      )..where((t) => t.id.equals(creditAccountId))).getSingle();

      await (_db.update(
        _db.accounts,
      )..where((t) => t.id.equals(debitAccountId))).write(
        AccountsCompanion(
          balanceCents: Value(debitAccount.balanceCents + amountCents),
        ),
      );

      await (_db.update(
        _db.accounts,
      )..where((t) => t.id.equals(creditAccountId))).write(
        AccountsCompanion(
          balanceCents: Value(creditAccount.balanceCents - amountCents),
        ),
      );
    });
  }
}
