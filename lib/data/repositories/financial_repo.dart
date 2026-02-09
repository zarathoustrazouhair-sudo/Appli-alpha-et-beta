import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../db/app_db.dart';
import '../providers.dart';

part 'financial_repo.g.dart';

@riverpod
Stream<List<Apartment>> apartmentsStream(ApartmentsStreamRef ref) {
  return ref.watch(financialRepositoryProvider).watchApartments();
}

@riverpod
Stream<double> apartmentBalance(ApartmentBalanceRef ref, int apartmentId) async* {
  final repo = ref.watch(financialRepositoryProvider);
  final transactionsStream = repo.watchTransactions(apartmentId);

  await for (final _ in transactionsStream) {
    final apartments = await repo.getApartments();
    try {
      final apartment = apartments.firstWhere((element) => element.id == apartmentId);
      yield await repo.calculateBalance(apartment);
    } catch (e) {
      yield 0.0;
    }
  }
}

@Riverpod(keepAlive: true)
FinancialRepository financialRepository(FinancialRepositoryRef ref) {
  final db = ref.watch(databaseProvider);
  return FinancialRepository(db);
}

class FinancialRepository {
  final AppDatabase _db;

  FinancialRepository(this._db);

  // Apartments
  Stream<List<Apartment>> watchApartments() {
    return _db.select(_db.apartments).watch();
  }

  Future<List<Apartment>> getApartments() {
    return _db.select(_db.apartments).get();
  }

  Future<int> addApartment(ApartmentsCompanion apartment) {
    return _db.into(_db.apartments).insert(apartment);
  }

  Future<bool> updateApartment(Apartment apartment) {
    return _db.update(_db.apartments).replace(apartment);
  }

  Future<int> deleteApartment(int id) {
    return (_db.delete(_db.apartments)..where((t) => t.id.equals(id))).go();
  }

  // Transactions
  Stream<List<Transaction>> watchTransactions(int apartmentId) {
    return (_db.select(_db.transactions)..where((t) => t.apartmentId.equals(apartmentId))).watch();
  }

  Future<List<Transaction>> getTransactions(int apartmentId) {
    return (_db.select(_db.transactions)..where((t) => t.apartmentId.equals(apartmentId))).get();
  }

  Future<int> addTransaction(TransactionsCompanion transaction) {
    return _db.into(_db.transactions).insert(transaction);
  }

  Future<bool> updateTransaction(Transaction transaction) {
    return _db.update(_db.transactions).replace(transaction);
  }

  Future<int> deleteTransaction(int id) {
    return (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
  }

  // Global Expenses
  Stream<List<Transaction>> watchGlobalTransactions() {
    return (_db.select(_db.transactions)..where((t) => t.apartmentId.isNull())).watch();
  }

  Future<List<Transaction>> getGlobalTransactions() {
    return (_db.select(_db.transactions)..where((t) => t.apartmentId.isNull())).get();
  }

  Future<List<Transaction>> getAllTransactions() {
    return _db.select(_db.transactions).get();
  }

  // Balance Calculation
  Future<double> calculateBalance(Apartment apartment) async {
    final now = DateTime.now();
    int monthsDue = (now.year - apartment.entryDate.year) * 12 + (now.month - apartment.entryDate.month);
    if (monthsDue < 0) monthsDue = 0;

    final theoreticalDebt = monthsDue * apartment.monthlyFee;

    // Optimized SQL SUM for income
    final query = _db.selectOnly(_db.transactions)
      ..addColumns([_db.transactions.amount.sum()])
      ..where(_db.transactions.apartmentId.equals(apartment.id))
      ..where(_db.transactions.type.equals('INCOME'));

    final result = await query.getSingle();
    final totalPaid = result.read(_db.transactions.amount.sum()) ?? 0.0;

    return (totalPaid + apartment.soldeInitial) - theoreticalDebt;
  }

  // Optimized Global Summary
  Future<Map<String, double>> getFinancialSummary() async {
    // Total Income
    final incomeQuery = _db.selectOnly(_db.transactions)
      ..addColumns([_db.transactions.amount.sum()])
      ..where(_db.transactions.type.equals('INCOME'));
    final incomeResult = await incomeQuery.getSingle();
    final totalIncome = incomeResult.read(_db.transactions.amount.sum()) ?? 0.0;

    // Total Expenses
    final expenseQuery = _db.selectOnly(_db.transactions)
      ..addColumns([_db.transactions.amount.sum()])
      ..where(_db.transactions.type.equals('EXPENSE'));
    final expenseResult = await expenseQuery.getSingle();
    final totalExpense = expenseResult.read(_db.transactions.amount.sum()) ?? 0.0;

    return {
      'income': totalIncome,
      'expense': totalExpense,
      'net': totalIncome - totalExpense,
    };
  }
}
