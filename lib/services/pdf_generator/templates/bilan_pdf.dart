import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/utils/currency_fmt.dart';
import '../../../data/db/app_db.dart';
import '../pdf_styles.dart';

class BilanPdf {
  static Future<Uint8List> generate({
    required pw.MemoryImage? logo,
    required String residenceName,
    required List<Transaction> transactions,
  }) async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);

    // Process data
    final expenses = transactions.where((t) => t.type == 'EXPENSE');
    final income = transactions.where((t) => t.type == 'INCOME');

    final totalIncome = income.fold(0.0, (sum, t) => sum + t.amount);
    final totalExpense = expenses.fold(0.0, (sum, t) => sum + t.amount);
    final netResult = totalIncome - totalExpense;

    // Group expenses by category
    final expensesByCategory = <String, double>{};
    for (final t in expenses) {
      expensesByCategory.update(t.category, (value) => value + t.amount, ifAbsent: () => t.amount);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader(logo, residenceName, formattedDate),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          pw.Text('BILAN FINANCIER', style: PdfStyles.headerStyle),
          pw.SizedBox(height: 20),

          _buildSummary(totalIncome, totalExpense, netResult),
          pw.SizedBox(height: 30),

          pw.Text('DÉTAIL DES DÉPENSES PAR CATÉGORIE', style: PdfStyles.subHeaderStyle),
          pw.SizedBox(height: 10),
          _buildExpensesTable(expensesByCategory),

          pw.SizedBox(height: 30),
          pw.Text('DÉTAIL DES RECETTES', style: PdfStyles.subHeaderStyle),
          pw.SizedBox(height: 10),
          pw.Text('Total des cotisations perçues : ${CurrencyFormatter.format(totalIncome)}', style: const pw.TextStyle(fontSize: 14)),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(pw.MemoryImage? logo, String residenceName, String date) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            if (logo != null) pw.Image(logo, width: 60, height: 60),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(residenceName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('BILAN ANNUEL', style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
                pw.Text('Date: $date', style: pw.TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Divider(),
        pw.SizedBox(height: 10),
      ],
    );
  }

  static pw.Widget _buildSummary(double income, double expense, double net) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        color: PdfColors.grey100,
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(children: [
            pw.Text('TOTAL RECETTES', style: pw.TextStyle(color: PdfColors.green, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(income), style: pw.TextStyle(fontSize: 16, color: PdfColors.green)),
          ]),
          pw.Column(children: [
            pw.Text('TOTAL DÉPENSES', style: pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(expense), style: pw.TextStyle(fontSize: 16, color: PdfColors.red)),
          ]),
          pw.Column(children: [
            pw.Text('RÉSULTAT NET', style: pw.TextStyle(color: PdfColors.blue, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(net), style: pw.TextStyle(fontSize: 16, color: PdfColors.blue)),
          ]),
        ],
      ),
    );
  }

  static pw.Widget _buildExpensesTable(Map<String, double> expensesByCategory) {
    return pw.TableHelper.fromTextArray(
      headers: ['Catégorie', 'Montant'],
      data: expensesByCategory.entries.map((e) => [e.key, CurrencyFormatter.format(e.value)]).toList(),
      headerStyle: PdfStyles.tableHeaderStyle,
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
      cellAlignment: pw.Alignment.centerLeft,
      cellAlignments: {
        1: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        'Page ${context.pageNumber} sur ${context.pagesCount} - Généré par Amandier Manager',
        style: PdfStyles.footerStyle,
      ),
    );
  }
}
