import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/financial_repo.dart';
import '../../data/repositories/settings_repo.dart';
import 'templates/bilan_pdf.dart';
import 'dart:io';

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

  // --- Generation Methods (In Memory) ---

  Future<Uint8List> generateGlobalStatusPdf() async {
    final logo = await _loadLogo();
    final residenceName = await _getResidenceName();

    final financialRepo = _ref.read(financialRepositoryProvider);
    final apartments = await financialRepo.getApartments();
    final balances = <int, double>{};
    for (final apt in apartments) {
      balances[apt.id] = await financialRepo.calculateBalance(apt);
    }

    // Optimization: Use aggregated summary
    final summary = await financialRepo.getFinancialSummary();
    final income = summary['income'] ?? 0.0;
    final expense = summary['expense'] ?? 0.0;

    // Solde caisse usually includes initial balances too?
    // Let's stick to simple: Net result + sum of initial balances
    final totalInitial = apartments.fold(0.0, (sum, a) => sum + a.soldeInitial);
    final soldeCaisse = (income + totalInitial) - expense;

    return GlobalStatusPdf.generate(
      logo: logo,
      residenceName: residenceName,
      apartments: apartments,
      balances: balances,
      soldeCaisse: soldeCaisse,
      totalExpenses: expense,
    );
  }

  Future<Uint8List> generateReceiptPdf(int transactionId) async {
    final logo = await _loadLogo();
    final residenceName = await _getResidenceName();

    final financialRepo = _ref.read(financialRepositoryProvider);
    final allTransactions = await financialRepo.getAllTransactions();
    final transaction = allTransactions.firstWhere((t) => t.id == transactionId);

    if (transaction.apartmentId == null) throw Exception('Global transaction');

    final apartments = await financialRepo.getApartments();
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

  // --- Output Actions ---

  Future<void> savePdfToRootFolder(String fileName, Uint8List bytes) async {
    final settingsRepo = _ref.read(settingsRepositoryProvider);
    final rootPath = await settingsRepo.getRootFolderPath();

    if (rootPath == null) throw Exception("Dossier racine non configuré");

    final file = File('$rootPath/$fileName');
    await file.writeAsBytes(bytes);
  }

  Future<void> printOrSharePdf(String fileName, Uint8List bytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
      name: fileName,
    );
  }
}
