import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart' as drift;
import '../../../data/database/database.dart';
import '../../../data/database/database_provider.dart';
import '../../../data/models/expense.dart' as entity;

part 'expense_repository.g.dart';

@riverpod
ExpenseRepository expenseRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ExpenseRepository(db);
}

class ExpenseRepository {
  final AppDatabase _db;
  ExpenseRepository(this._db);

  Future<List<entity.Expense>> getExpenses() async {
    final rows =
        await (_db.select(_db.expenses)..orderBy([
              (t) => drift.OrderingTerm(
                expression: t.date,
                mode: drift.OrderingMode.desc,
              ),
            ]))
            .get();
    return rows
        .map(
          (e) => entity.Expense(
            id: e.id,
            title: e.title,
            amount: e.amount,
            category: e.category,
            proofImagePath: e.proofImagePath,
            date: e.date,
            providerName: e.providerName,
            providerId: e.providerId,
          ),
        )
        .toList();
  }

  Future<int> addExpense(entity.Expense expense) {
    return _db
        .into(_db.expenses)
        .insert(
          ExpensesCompanion(
            title: drift.Value(expense.title),
            amount: drift.Value(expense.amount),
            category: drift.Value(expense.category),
            proofImagePath: drift.Value(expense.proofImagePath),
            date: drift.Value(expense.date),
            providerName: drift.Value(expense.providerName),
            providerId: drift.Value(expense.providerId),
          ),
        );
  }

  Future<void> deleteExpense(int id) {
    return (_db.delete(_db.expenses)..where((t) => t.id.equals(id))).go();
  }
}
