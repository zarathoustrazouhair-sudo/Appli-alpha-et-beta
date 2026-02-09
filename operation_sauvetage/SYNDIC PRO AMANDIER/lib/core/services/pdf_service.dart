import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../domain/entities/payment.dart';
import '../../domain/entities/resident.dart';
import '../../features/ag/domain/meeting.dart';
import '../utils/formatters.dart';

class PdfService {
  final Map<String, String> config;

  PdfService(this.config);

  Future<pw.MemoryImage> _loadLogo() async {
    final logoBytes = await rootBundle.load('assets/images/logo.png');
    return pw.MemoryImage(logoBytes.buffer.asUint8List());
  }

  pw.Widget _buildFooter() {
    return pw.Container(
      alignment: pw.Alignment.center,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        "Message généré automatiquement par l'application Syndic L'Amandier B.",
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey),
      ),
    );
  }

  Future<File> generateReceipt(
    Payment payment,
    Resident resident,
    String reason,
    String nextDueDate,
  ) async {
    final pdf = pw.Document();
    final logoImage = await _loadLogo();

    final now = DateTime.now();
    final receiptId = '${now.year}-${payment.id}';
    final amountWords = Formatters.amountToWords(payment.amount);

    final residenceName = config['RESIDENCE_NAME'] ?? 'SYNDIC L\'AMANDIER B';
    final syndicName = config['SYNDIC_NAME'] ?? 'M. Abdelati KENBOUCHI';
    final city = config['CITY'] ?? 'Bouskoura';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 2), // Professional Border
            ),
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logoImage, width: 50, height: 50),
                    pw.Text(
                      residenceName,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Syndic: $syndicName',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                      'REÇU N° $receiptId',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ),

                pw.SizedBox(height: 1.0 * PdfPageFormat.cm),

                // Body
                pw.Text(
                  'Je soussigné, Syndic de la copropriété, reconnais avoir reçu de :',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'M/Mme ${resident.name}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  'Appartement N° ${resident.apartment}, Immeuble ${resident.building}',
                  style: const pw.TextStyle(fontSize: 12),
                ),

                pw.SizedBox(height: 15),

                pw.Row(
                  children: [
                    pw.Text(
                      'La somme de : ',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                      '${Formatters.formatMoney(payment.amount)} ',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    pw.Text(
                      '($amountWords Dirhams)',
                      style: pw.TextStyle(
                        fontStyle: pw.FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),
                pw.Text(
                  'Motif : $reason',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  'Date du paiement : ${payment.date.day}/${payment.date.month}/${payment.date.year}',
                  style: const pw.TextStyle(fontSize: 12),
                ),

                pw.Spacer(),

                // Signature
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Fait à $city, le ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'Le Syndic',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
                      pw.Text(
                        '(Signature)',
                        style: const pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(p.join(output.path, 'receipt_$receiptId.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> generateGlobalReport(
    List<Resident> residents,
    double lastMonthExpenses,
    double yearlyExpenses,
    Map<int, double> balances,
  ) async {
    final pdf = pw.Document();
    final residenceName = config['RESIDENCE_NAME'] ?? 'RÉSIDENCE';
    // No logo requested here but footer is good practice.

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'ÉTAT DES COTISATIONS - $residenceName',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              pw.SizedBox(height: 20),

              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(4),
                  3: const pw.FlexColumnWidth(2),
                  4: const pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      _buildCell('Etg', isHeader: true),
                      _buildCell('Apt N°', isHeader: true),
                      _buildCell('Copropriétaire', isHeader: true),
                      _buildCell('Solde', isHeader: true),
                      _buildCell('Payé Jusqu\'au', isHeader: true),
                    ],
                  ),
                  ...residents.map((r) {
                    final balance = balances[r.id] ?? 0.0;
                    return pw.TableRow(
                      children: [
                        _buildCell('${r.floor ?? '-'}'),
                        _buildCell(r.apartment),
                        _buildCell(r.name),
                        _buildBalanceCell(balance),
                        _buildCell(
                          _calculatePaidUntil(
                            r.startDate,
                            balance,
                            r.monthlyFee,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatBox(
                    'Total Arriérés',
                    Formatters.formatMoney(
                      balances.values
                          .where((b) => b < 0)
                          .fold(0, (sum, b) => sum + b),
                    ),
                  ),
                  _buildStatBox(
                    'Dépenses Mois Dernier',
                    Formatters.formatMoney(lastMonthExpenses),
                  ),
                  _buildStatBox(
                    'Cumul Dépenses Annuel',
                    Formatters.formatMoney(yearlyExpenses),
                  ),
                ],
              ),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(p.join(output.path, 'global_report.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> generateConvocation(
    Resident resident,
    String agenda,
    String date,
    String place,
  ) async {
    final pdf = pw.Document();
    final logoImage = await _loadLogo();

    final residenceName = config['RESIDENCE_NAME'] ?? 'SYNDIC L\'AMANDIER B';
    final city = config['CITY'] ?? 'Bouskoura';
    final syndicName = config['SYNDIC_NAME'] ?? 'M. Abdelati KENBOUCHI';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 50, height: 50),
                  pw.Text(
                    residenceName,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.cm),

              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('À l\'attention de M/Mme ${resident.name}'),
                    pw.Text(
                      'Appartement ${resident.apartment}, Immeuble ${resident.building}',
                    ),
                    pw.Text('$residenceName, $city'),
                  ],
                ),
              ),
              pw.SizedBox(height: 2 * PdfPageFormat.cm),

              pw.Center(
                child: pw.Text(
                  'CONVOCATION À L\'ASSEMBLÉE GÉNÉRALE ORDINAIRE',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),

              pw.Text('Mesdames, Messieurs les copropriétaires,'),
              pw.SizedBox(height: 10),
              pw.Text(
                'Vous êtes convoqués à l\'Assemblée Générale qui se tiendra le $date à $place.',
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'ORDRE DU JOUR :',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey),
                ),
                child: pw.Text(agenda),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Conformément au règlement, si le quorum n\'est pas atteint, une seconde assemblée sera convoquée.',
              ),

              pw.SizedBox(height: 2 * PdfPageFormat.cm),

              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  children: [
                    pw.Text('Le Syndic, $syndicName'),
                    pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
                    pw.Text('(Signature)'),
                  ],
                ),
              ),
              pw.Spacer(),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(p.join(output.path, 'convocation_${resident.id}.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> generatePV(
    Meeting meeting,
    double quorum,
    List<Resident> absents,
  ) async {
    final pdf = pw.Document();
    final logoImage = await _loadLogo();

    final residenceName = config['RESIDENCE_NAME'] ?? 'SYNDIC L\'AMANDIER B';
    final syndicName = config['SYNDIC_NAME'] ?? 'M. Abdelati KENBOUCHI';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logoImage, width: 50, height: 50),
                    pw.Text(
                      'PV AG DU ${meeting.date.day}/${meeting.date.month}/${meeting.date.year}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                'L\'an ${meeting.date.year}, le ${meeting.date.day}/${meeting.date.month} à ${meeting.date.hour}h${meeting.date.minute}, les copropriétaires de la $residenceName se sont réunis en Assemblée Générale au lieu suivant : ${meeting.location}.',
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                'CONTEXTE ET PRÉSENCE',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Quorum atteint : ${quorum >= 50 ? "OUI" : "NON"} (${quorum.toStringAsFixed(1)}%).',
              ),
              pw.SizedBox(height: 10),

              if (absents.isNotEmpty) ...[
                pw.Text(
                  'Membres absents :',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Wrap(
                  children: absents.map((r) => pw.Text('${r.name}, ')).toList(),
                ),
                pw.SizedBox(height: 20),
              ],

              pw.Text(
                'DÉLIBÉRATIONS',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text('L\'ordre du jour suivant a été débattu :'),
              pw.SizedBox(height: 5),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                color: PdfColors.grey100,
                child: pw.Text(meeting.agenda),
              ),

              pw.Spacer(),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Le Président de séance'),
                      pw.SizedBox(height: 2 * PdfPageFormat.cm),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('Le Syndic'),
                      pw.Text(
                        syndicName,
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.SizedBox(height: 2 * PdfPageFormat.cm),
                    ],
                  ),
                ],
              ),
              _buildFooter(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(p.join(output.path, 'pv_ag_${meeting.id}.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  String generateWhatsappConvocation(
    Resident resident,
    String agenda,
    String date,
    String place,
  ) {
    return 'Bonjour ${resident.name}, Convocation officielle AG ${config['RESIDENCE_NAME'] ?? "L'Amandier B"}.\n📅 Date: $date\n📍 Lieu: $place\n📝 Sujet: $agenda\nMerci de confirmer votre présence. Le Syndic.';
  }

  pw.Widget _buildCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Center(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  pw.Widget _buildBalanceCell(double balance) {
    return pw.Container(
      color: Formatters.getBackgroundColor(balance),
      padding: const pw.EdgeInsets.all(5),
      child: pw.Center(
        child: pw.Text(
          Formatters.formatMoney(balance),
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            color: Formatters.getContrastColor(balance),
            fontWeight: pw.FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  pw.Widget _buildStatBox(String title, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Column(
        children: [
          pw.Text(title, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 5),
          pw.Text(
            value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _calculatePaidUntil(
    DateTime startDate,
    double balance,
    int monthlyFee,
  ) {
    // New Smart Logic: Credit = Sum(Payments) - (Months * Fee) = Balance
    // If balance > 0, we have advanced payment.
    // monthsCovered = balance / fee (floor)

    if (balance < 0) return 'Dette'; // Or handled by visual color

    int monthsCovered = (balance / monthlyFee).floor();
    if (monthsCovered == 0 && balance >= 0) return 'À Jour';

    // Last covered date = Now + monthsCovered
    // Wait, if I am "À Jour", I paid THIS month.
    // If I have +250 credit, I paid NEXT month.
    // So "À Jour" implies paid until END of current month?
    // Let's stick to "Payé jusqu'au [Month/Year]" logic relative to NOW.

    final now = DateTime.now();
    // If monthsCovered = 1 (250 credit), it covers next month.
    final paidUntil = DateTime(now.year, now.month + monthsCovered);

    return '${paidUntil.month}/${paidUntil.year}';
  }
}
