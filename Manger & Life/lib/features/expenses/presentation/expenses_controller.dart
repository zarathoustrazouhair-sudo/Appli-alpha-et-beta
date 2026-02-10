import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/expense.dart';
import '../../dashboard/presentation/dashboard_controller.dart';
import '../domain/expense_repository.dart';

part 'expenses_controller.g.dart';

@riverpod
class ExpensesList extends _$ExpensesList {
  @override
  FutureOr<List<Expense>> build() async {
    final repository = ref.watch(expenseRepositoryProvider);
    return repository.getExpenses();
  }

  Future<void> addExpense(
    String title,
    double amount,
    String category,
    DateTime date,
    String imagePath, {
    String? providerName,
    int? providerId,
  }) async {
    final repository = ref.read(expenseRepositoryProvider);
    final expense = Expense(
      id: 0,
      title: title,
      amount: amount,
      category: category,
      proofImagePath: imagePath,
      date: date,
      providerName: providerName,
      providerId: providerId,
    );
    await repository.addExpense(expense);
    ref.invalidateSelf();
    ref.invalidate(dashboardStatsProvider);
  }

  Future<void> deleteExpense(Expense expense) async {
    final repository = ref.read(expenseRepositoryProvider);

    // 1. Delete File
    final file = File(expense.proofImagePath);
    if (await file.exists()) {
      await file.delete();
    }

    // 2. Delete from DB
    await repository.deleteExpense(expense.id);

    ref.invalidateSelf();
    ref.invalidate(dashboardStatsProvider);
  }
}
