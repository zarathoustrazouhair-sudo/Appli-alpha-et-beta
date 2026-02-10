import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'expenses_controller.dart';
import 'add_expense_modal.dart';
import 'expense_detail_screen.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dépenses')),
      body: expensesAsync.when(
        data: (expenses) {
          if (expenses.isEmpty)
            return const Center(child: Text('Aucune dépense.'));
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];

              // Display Logic: Category - Provider
              String mainText = expense.category;
              if (expense.providerName != null &&
                  expense.providerName!.isNotEmpty) {
                mainText += " - ${expense.providerName}";
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.file(
                      File(expense.proofImagePath),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  title: Text(
                    mainText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${expense.title} • ${expense.date.toString().split(' ')[0]}",
                  ),
                  trailing: Text(
                    '-${expense.amount.toStringAsFixed(2)} DH',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExpenseDetailScreen(expense: expense),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddExpenseModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
