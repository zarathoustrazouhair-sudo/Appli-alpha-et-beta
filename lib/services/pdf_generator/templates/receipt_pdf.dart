import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/utils/currency_fmt.dart';
import '../../../data/db/app_db.dart';
import '../pdf_styles.dart';

class ReceiptPdf {
  static Future<Uint8List> generate({
    required pw.MemoryImage? logo,
    required String residenceName,
    required Apartment apartment,
    required Transaction transaction,
  }) async {
    final pdf = pw.Document();

    final date = DateFormat('dd/MM/yyyy').format(transaction.date);

    // Use A5 format
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  if (logo != null) pw.Image(logo, width: 60, height: 60),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(residenceName, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.Text('REÇU DE PAIEMENT', style: pw.TextStyle(fontSize: 16, color: PdfColors.blue900, fontWeight: pw.FontWeight.bold)),
                      pw.Text('N° ${transaction.id}', style: pw.TextStyle(fontSize: 12, color: PdfColors.red)),
                      pw.Text('Date: $date', style: pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 30),

              // Body
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Reçu de M./Mme : ${apartment.ownerName}', style: pw.TextStyle(fontSize: 14)),
                    pw.SizedBox(height: 10),
                    pw.Text('Pour l\'appartement : ${apartment.number}', style: pw.TextStyle(fontSize: 14)),
                    pw.SizedBox(height: 20),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Montant :', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                        pw.Text(CurrencyFormatter.format(transaction.amount), style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text('Mode de règlement : ${transaction.category}', style: pw.TextStyle(fontSize: 12)), // Assuming category stores mode for now
                    pw.Text('Description : ${transaction.description}', style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ),

              pw.Spacer(),

              // Signature
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Le Syndic', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 40),
                      pw.Container(width: 100, height: 1, color: PdfColors.black),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text('Généré par Amandier Manager', style: PdfStyles.footerStyle),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
