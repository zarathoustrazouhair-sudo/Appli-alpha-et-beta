import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/utils/currency_fmt.dart';
import '../../../data/db/app_db.dart';
import '../pdf_styles.dart';

class GlobalStatusPdf {
  static Future<Uint8List> generate({
    required pw.MemoryImage? logo,
    required String residenceName,
    required List<Apartment> apartments,
    required Map<int, double> balances,
    required double soldeCaisse,
    required double totalExpenses,
  }) async {
    final pdf = pw.Document();

    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader(logo, residenceName, formattedDate),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildTable(apartments, balances),
          pw.SizedBox(height: 20),
          _buildSummary(balances, soldeCaisse, totalExpenses),
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
                pw.Text('SITUATION DES COTISATIONS', style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
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

  static pw.Widget _buildTable(List<Apartment> apartments, Map<int, double> balances) {
    return pw.TableHelper.fromTextArray(
      headers: ['Appartement', 'Propriétaire', 'État', 'Montant Dû / Solde'],
      data: apartments.map((apt) {
        final balance = balances[apt.id] ?? 0.0;
        final isLate = balance < -0.01;
        final status = isLate ? 'RETARD' : 'À JOUR';
        final amount = CurrencyFormatter.format(balance);

        return [
          apt.number,
          apt.ownerName,
          status,
          amount,
        ];
      }).toList(),
      headerStyle: PdfStyles.tableHeaderStyle,
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
      cellAlignment: pw.Alignment.centerLeft,
      cellAlignments: {
        3: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget _buildSummary(Map<int, double> balances, double soldeCaisse, double totalExpenses) {
    final totalArrears = balances.values.where((b) => b < 0).fold(0.0, (sum, b) => sum + b.abs());

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('TOTAL ARRIÉRÉS', style: pw.TextStyle(color: PdfColors.red, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(totalArrears), style: pw.TextStyle(fontSize: 16, color: PdfColors.red)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('TOTAL DÉPENSES', style: pw.TextStyle(color: PdfColors.grey700, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(totalExpenses), style: pw.TextStyle(fontSize: 16, color: PdfColors.grey700)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('SOLDE EN CAISSE', style: pw.TextStyle(color: PdfColors.green, fontWeight: pw.FontWeight.bold)),
            pw.Text(CurrencyFormatter.format(soldeCaisse), style: pw.TextStyle(fontSize: 16, color: PdfColors.green)),
          ],
        ),
      ],
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
