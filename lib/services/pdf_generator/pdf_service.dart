import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/financial_repo.dart';
import '../../data/repositories/settings_repo.dart';
import 'templates/bilan_pdf.dart';
import 'templates/global_status_pdf.dart';
import 'templates/receipt_pdf.dart';

part 'pdf_service.g.dart';

@riverpod
PdfService pdfService(PdfServiceRef ref) {
  return PdfService(ref);
}

class PdfService {
  final Ref _ref;

  PdfService(this._ref);

  Future<pw.MemoryImage?> _loadLogo() async {
    // We use ref.read because this is a short-lived operation triggered by UI
    final settingsRepo = _ref.read(settingsRepositoryProvider);
    final path = await settingsRepo.getLogoPath();
    if (path == null) return null;
    final file = File(path);
    if (!await file.exists()) return null;
    final bytes = await file.readAsBytes();
    return pw.MemoryImage(bytes);
  }

  Future<String> _getResidenceName() async {
    final settingsRepo = _ref.read(settingsRepositoryProvider);
    return await settingsRepo.getResidenceName() ?? 'Résidence Inconnue';
  }

  Future<Uint8List> generateGlobalStatusPdf() async {
    final logo = await _loadLogo();
    final residenceName = await _getResidenceName();

    final financialRepo = _ref.read(financialRepositoryProvider);
    final apartments = await financialRepo.getApartments();

    // Calculate balances
    final balances = <int, double>{};
    for (final apt in apartments) {
      balances[apt.id] = await financialRepo.calculateBalance(apt);
    }

    // Get solde en caisse (Total Income - Total Expense)
    // Wait, solde en caisse is (All Income) - (All Expense).
    // Or (Total Paid by all apts + Total Solde Initial) - (Total Expenses).
    // Or just Bank Balance.

    // Total Arriérés = Sum of negative balances (debts).
    // Total Expenses = Sum of expenses.

    final allTx = await financialRepo.getAllTransactions();
    final totalIncome = allTx.where((t) => t.type == 'INCOME').fold(0.0, (sum, t) => sum + t.amount);
    final totalExpense = allTx.where((t) => t.type == 'EXPENSE').fold(0.0, (sum, t) => sum + t.amount);

    // Also include initial balances in solde en caisse?
    final totalInitialSolde = apartments.fold(0.0, (sum, a) => sum + a.soldeInitial);

    final soldeCaisse = (totalIncome + totalInitialSolde) - totalExpense;
    final totalExpensesYear = totalExpense; // Assuming all expenses are for this year or just total.

    return GlobalStatusPdf.generate(
      logo: logo,
      residenceName: residenceName,
      apartments: apartments,
      balances: balances,
      soldeCaisse: soldeCaisse,
      totalExpenses: totalExpensesYear,
    );
  }

  Future<Uint8List> generateReceiptPdf(int transactionId) async {
    final logo = await _loadLogo();
    final residenceName = await _getResidenceName();

    final financialRepo = _ref.read(financialRepositoryProvider);

    // We need to fetch the transaction
    final allTransactions = await financialRepo.getAllTransactions();
    final transaction = allTransactions.firstWhere((t) => t.id == transactionId);

    // Fetch apartment
    final apartments = await financialRepo.getApartments();
    // apartmentId is nullable in transaction but for receipt it should exist
    if (transaction.apartmentId == null) {
      throw Exception('Cannot generate receipt for global transaction');
    }
    final apartment = apartments.firstWhere((a) => a.id == transaction.apartmentId);

    return ReceiptPdf.generate(
      logo: logo,
      residenceName: residenceName,
      apartment: apartment,
      transaction: transaction,
    );
  }

  Future<Uint8List> generateBilanPdf() async {
    final logo = await _loadLogo();
    final residenceName = await _getResidenceName();

    final financialRepo = _ref.read(financialRepositoryProvider);
    final transactions = await financialRepo.getAllTransactions();

    return BilanPdf.generate(
      logo: logo,
      residenceName: residenceName,
      transactions: transactions,
    );
  }
}
