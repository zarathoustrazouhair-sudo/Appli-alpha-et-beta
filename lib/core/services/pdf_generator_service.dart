import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:residence_lamandier_b/features/users/data/user_entity.dart'; // Ensure correct import for Drift classes or map accordingly

class PdfGeneratorService {
  final String _residenceName = "Résidence L'Amandier B";
  final String _syndicName = "M. Abdelati KENBOUCHI";
  final String _jurisdiction = "Tribunal de Première Instance de Casablanca";

  Future<void> generateFinancialReport(List<dynamic> users, List<dynamic> transactions, double monthlyFee) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildHeader("RAPPORT FINANCIER GLOBAL"),
              pw.SizedBox(height: 20),

              // TABLE
              pw.Table.fromTextArray(
                context: context,
                border: null,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.blue900),
                rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300))),
                cellAlignment: pw.Alignment.centerLeft,
                headers: <String>['Appartement', 'Résident', 'Solde (DH)', 'Statut'],
                data: users.map((user) {
                  // user is expected to be a Drift Row or similar
                  final balance = (user.balance as num).toDouble();
                  final status = balance < 0 ? 'EN RETARD' : 'À JOUR';

                  return [
                    user.apartmentNumber?.toString() ?? '-',
                    user.name,
                    balance.toStringAsFixed(2),
                    status
                  ];
                }).toList(),
              ),

              // FOOTER
              pw.Spacer(),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Généré par le système Amandier B - God Mode"),
                  pw.Text("Total Trésorerie: ${users.fold(0.0, (sum, u) => sum + (u.balance as num)).toStringAsFixed(2)} DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  // FINANCE_RECU
  Future<void> generateReceipt({
    required int transactionId,
    required String residentName,
    required int lotNumber,
    required double amount,
    required String mode, // Chèque/Espèces
    required String period,
    required double oldBalance,
    required double newBalance,
  }) async {
    final doc = pw.Document();
    final now = DateTime.now();

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader("REÇU DE PAIEMENT N° $transactionId"),
            pw.SizedBox(height: 30),
            _buildInfoRow("DATE DU PAIEMENT", "${now.day}/${now.month}/${now.year}"),
            _buildInfoRow("SYNDIC", _syndicName),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.SizedBox(height: 10),
            _buildInfoRow("REÇU DE", "$residentName (Lot $lotNumber)"),
            _buildInfoRow("MONTANT", "$amount DH (Cotisation Fixe)"),
            _buildInfoRow("MODE DE RÈGLEMENT", mode),
            _buildInfoRow("AFFECTATION", "Cotisation période $period"),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Ancien Solde: $oldBalance DH"),
                  pw.Text("->"),
                  pw.Text("Nouveau Solde: $newBalance DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ),
            pw.Spacer(),
            pw.Text("Signature du Syndic:", style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
            pw.SizedBox(height: 50),
          ],
        );
      },
    ));

    await Printing.layoutPdf(onLayout: (format) => doc.save());
  }

  // OPS_MISE_EN_DEMEURE
  Future<void> generateWarningLetter({
    required String residentName,
    required double debtAmount,
    required int delayDays,
  }) async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader("MISE EN DEMEURE (Loi 18-00)"),
            pw.SizedBox(height: 40),
            pw.Text("À l'attention de M./Mme $residentName", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 20),
            pw.Paragraph(text: "Sauf règlement de votre part sous un délai de $delayDays jours, le dossier sera transmis au $_jurisdiction pour recouvrement forcé."),
            pw.SizedBox(height: 10),
            pw.Text("Montant impayé (Cotisations Fixes) : $debtAmount DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.red)),
            pw.SizedBox(height: 40),
            pw.Text("Signé:"),
            pw.Text(_syndicName),
            pw.Text("Syndic de la $_residenceName"),
          ],
        );
      },
    ));

    await Printing.layoutPdf(onLayout: (format) => doc.save());
  }

  pw.Widget _buildHeader(String title) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(_residenceName, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.Text("Date: ${DateTime.now().toString().split(' ')[0]}"),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(width: 150, child: pw.Text("$label :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }
}
