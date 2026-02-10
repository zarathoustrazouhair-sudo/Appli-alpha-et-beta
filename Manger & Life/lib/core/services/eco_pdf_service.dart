import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../data/database/database.dart';
import '../../data/models/resident.dart' as domain;

// DTO for Financial Stats
class FinancialStats {
  final double totalDebt;
  final double lastMonthExpenses;
  final double totalExpenses;

  FinancialStats({
    required this.totalDebt,
    required this.lastMonthExpenses,
    required this.totalExpenses,
  });
}

// DTO for Resident Report Row
class ResidentReportItem {
  final domain.Resident resident;
  final double balance;

  ResidentReportItem({required this.resident, required this.balance});
}

class EcoPdfService {
  final Map<String, String> config;

  EcoPdfService(this.config);

  pw.TextStyle _getSerifStyle({
    double fontSize = 11,
    bool isBold = false,
    bool isItalic = false,
    PdfColor? color,
  }) {
    return pw.TextStyle(
      font: isItalic
          ? pw.Font.timesItalic()
          : (isBold ? pw.Font.timesBold() : pw.Font.times()),
      fontSize: fontSize,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      fontStyle: isItalic ? pw.FontStyle.italic : pw.FontStyle.normal,
      color: color ?? PdfColors.black,
    );
  }

  Future<pw.MemoryImage?> _loadLogo() async {
    final customPath = config['LOGO_PATH'];
    if (customPath != null && File(customPath).existsSync()) {
      return pw.MemoryImage(File(customPath).readAsBytesSync());
    }
    try {
      final logoBytes = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(logoBytes.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }

  pw.Widget _buildHeader(pw.MemoryImage? logo) {
    final residence = config['RESIDENCE_NAME'] ?? "RÉSIDENCE L'AMANDIER B";
    final syndic = config['SYNDIC_NAME'] ?? "Le Syndic";
    final phone = config['SYNDIC_PHONE'] ?? "";

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
      ),
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          if (logo != null)
            pw.Image(logo, width: 60, height: 60)
          else
            pw.Text(
              residence,
              style: _getSerifStyle(isBold: true, fontSize: 14),
            ),

          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                residence,
                style: _getSerifStyle(isBold: true, fontSize: 12),
              ),
              pw.Text("Syndic: $syndic", style: _getSerifStyle(fontSize: 10)),
              if (phone.isNotEmpty)
                pw.Text("Tél: $phone", style: _getSerifStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter() {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 20),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(width: 0.5)),
      ),
      padding: const pw.EdgeInsets.only(top: 5),
      child: pw.Column(
        children: [
          pw.Text(
            "Document généré par SyndicPro - Conforme Loi 43-20 & Loi 18-00.",
            style: _getSerifStyle(fontSize: 8),
          ),
          pw.Text(
            "Données personnelles protégées (Loi 09-08).",
            style: _getSerifStyle(fontSize: 8),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            "Ce rapport est généré automatiquement par l'application Amandier Manager. Si vous constatez une erreur, merci de prendre contact avec le Syndic ou son Adjoint.",
            style: _getSerifStyle(fontSize: 6, isItalic: true, color: PdfColors.grey),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<File> _savePdf(pw.Document pdf, String filename) async {
    final output = await getTemporaryDirectory();
    final file = File(p.join(output.path, filename));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // Helper: Paid Until Calculation
  String _calculatePaidUntil(double balance, int monthlyFee) {
    if (balance <= 0) return "⚠️ RETARD";
    if (monthlyFee <= 0) return "N/A";
    
    final monthsAdvance = (balance / monthlyFee).floor();
    if (monthsAdvance < 1) return "✅ À jour";
    
    return "✅ +$monthsAdvance Mois";
  }

  // GOD VIEW REPORT
  Future<File> generateGlobalReport(
    List<ResidentReportItem> items,
    FinancialStats stats,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final date = DateTime.now();
    final monthStr = "${date.month}/${date.year}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (context) => pw.Column(
          children: [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logo != null) pw.Image(logo, width: 50, height: 50),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "ÉTAT DES COTISATIONS",
                      style: pw.TextStyle(
                        font: pw.Font.helveticaBold(), // Modern bold
                        fontSize: 18,
                      ),
                    ),
                    pw.Text(
                      "MOIS DE $monthStr",
                      style: pw.TextStyle(
                        font: pw.Font.helvetica(),
                        fontSize: 12,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 0.5, color: PdfColors.grey400),
            pw.SizedBox(height: 10),

            // Table Header
            pw.Row(
              children: [
                pw.Expanded(flex: 15, child: pw.Text("ÉTAGE", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.grey700))),
                pw.Expanded(flex: 15, child: pw.Text("APPART.", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.grey700))),
                pw.Expanded(flex: 30, child: pw.Text("NOM & PRÉNOM", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.grey700))),
                pw.Expanded(flex: 20, child: pw.Text("SITUATION", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.grey700))),
                pw.Expanded(flex: 20, child: pw.Text("PAYÉ JUSQU'À", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.grey700))),
              ],
            ),
            pw.Divider(thickness: 0.5),

            // Table Rows
            ...items.map((item) {
              final r = item.resident;
              final balance = item.balance;
              final balanceStr = "${balance > 0 ? '+' : ''}${balance.toStringAsFixed(0)} DH";
              final paidUntil = _calculatePaidUntil(balance, r.monthlyFee);
              
              final floorStr = r.floor != null ? "${r.floor}ème" : "RDC";

              return pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 6),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 0.2, color: PdfColors.grey300)),
                ),
                child: pw.Row(
                  children: [
                    pw.Expanded(flex: 15, child: pw.Text(floorStr, style: const pw.TextStyle(fontSize: 10))),
                    pw.Expanded(flex: 15, child: pw.Text(r.apartment, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12))),
                    pw.Expanded(flex: 30, child: pw.Text(r.name, style: const pw.TextStyle(fontSize: 10))),
                    pw.Expanded(
                      flex: 20,
                      child: pw.Text(
                        balanceStr,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                          color: balance < 0 ? PdfColors.red : PdfColors.black,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 20,
                      child: pw.Text(
                        paidUntil,
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: paidUntil.contains("RETARD") ? PdfColors.red : PdfColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            pw.Spacer(),

            // Footer KPIs
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: const pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(4)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("RESTE À RECOUVRER", style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                      pw.Text("${stats.totalDebt.abs().toStringAsFixed(0)} DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12, color: PdfColors.red)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("DÉPENSES (M-1)", style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                      pw.Text("${stats.lastMonthExpenses.toStringAsFixed(0)} DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("CUMUL DÉPENSES", style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                      pw.Text("${stats.totalExpenses.toStringAsFixed(0)} DH", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            
            pw.SizedBox(height: 10),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'etat_global_${date.millisecondsSinceEpoch}.pdf');
  }

  // --- EXISTING METHODS (UNCHANGED) ---
  
  // 1. APPEL DE FONDS
  Future<File> generateAppelDeFonds(
    domain.Resident resident,
    int amountCents,
    int quarter,
    int year,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final amount = (amountCents / 100.0).toStringAsFixed(2);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "APPEL DE FONDS - TRIMESTRE $quarter/$year",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Participation aux charges communes (Art. 24 Loi 18-00)",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "Cher(e) copropriétaire, Mr/Mme ${resident.name},",
              style: _getSerifStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Afin d'assurer le bon fonctionnement de notre résidence (nettoyage, électricité, gardiennage) pour le trimestre à venir, nous vous invitons à régler votre cotisation.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Montant à régler : $amount DH",
              style: _getSerifStyle(fontSize: 14, isBold: true),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Ce budget a été voté lors de notre dernière Assemblée Générale. Votre contribution ponctuelle permet d'éviter les coupures de services et de maintenir la valeur de notre bien commun.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),
            pw.Text("Merci de votre réactivité.", style: _getSerifStyle()),

            pw.Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'appel_fonds_${resident.id}.pdf');
  }

  // 2. MISE EN DEMEURE
  Future<File> generateMiseEnDemeure(
    domain.Resident resident,
    int debtCents,
    String randomHash,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final city = config['CITY'] ?? 'Casablanca';
    final jurisdiction =
        config['JURISDICTION'] ??
        "Tribunal de Première Instance de CASABLANCA"; // Strict Default
    final syndicName = config['SYNDIC_NAME'] ?? 'Le Syndic';
    final date = DateTime.now();
    final formattedDate = "${date.day}/${date.month}/${date.year}";
    final amount = (debtCents / 100.0).toStringAsFixed(2);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "RELANCE ADMINISTRATIVE - CHARGES DE COPROPRIÉTÉ",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Mise en demeure amiable (Art. 25 & 35 Loi 18-00)",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ), // Updated citation
            pw.SizedBox(height: 30),

            pw.Text(
              "Cher(e) voisin(e), Mr/Mme ${resident.name},",
              style: _getSerifStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Sauf erreur de notre part, la vérification comptable de ce jour indique un solde débiteur de : $amount DH.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Nous sommes certains qu'il s'agit d'un simple oubli. Cependant, en tant que syndic bénévole, je suis tenu par la loi d'assurer l'équilibre financier de l'immeuble. Sans ces fonds, nous ne pouvons payer les prestataires communs.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Nous vous invitons à régulariser cette situation sous 15 jours. Ce courrier est une formalité administrative nécessaire (Loi 18-00) avant toute autre procédure auprès du $jurisdiction.",
              style: _getSerifStyle(),
            ), // Mention Jurisdiction
            pw.SizedBox(height: 15),
            pw.Text(
              "Comptant sur votre compréhension et votre civisme,",
              style: _getSerifStyle(),
            ),

            pw.SizedBox(height: 40),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                children: [
                  pw.Text(
                    "Fait à $city, le $formattedDate",
                    style: _getSerifStyle(),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text(
                      "Le Syndic Bénévole\n$syndicName",
                      style: _getSerifStyle(isBold: true),
                    ),
                  ),
                ],
              ),
            ),

            pw.Spacer(),
            pw.Text("Hash: $randomHash", style: _getSerifStyle(fontSize: 8)),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'mise_en_demeure_${resident.id}.pdf');
  }

  // 3. RECEIPT
  Future<File> generateReceipt(
    Transaction transaction,
    String residentName, {
    String paymentMethod = "Espèces",
  }) async {
    final pdf = pw.Document();
    final logo = await _loadLogo(); // Used inside container? Maybe small.
    // Receipts are A5 Landscape, space is tight.
    // We'll put header minimal.
    final residenceName = config['RESIDENCE_NAME'] ?? 'RÉSIDENCE';
    final amount = (transaction.amountCents / 100.0).toStringAsFixed(2);
    final date = transaction.date;
    final dateStr = "${date.day}/${date.month}/${date.year}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        margin: const pw.EdgeInsets.all(30),
        build: (context) => pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  if (logo != null) pw.Image(logo, width: 40, height: 40),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        "QUITTANCE DE PAIEMENT",
                        style: _getSerifStyle(fontSize: 16, isBold: true),
                      ),
                      pw.Text(
                        "Preuve libératoire de règlement",
                        style: _getSerifStyle(fontSize: 10, isItalic: true),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                "Le Syndic de la $residenceName certifie avoir reçu de Mr/Mme $residentName la somme de :",
                style: _getSerifStyle(),
              ),
              pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text(
                  "$amount DH",
                  style: _getSerifStyle(fontSize: 18, isBold: true),
                ),
              ),
              pw.SizedBox(height: 15),

              pw.Text(
                "Mode de règlement : $paymentMethod",
                style: _getSerifStyle(),
              ),
              pw.Text("Date : $dateStr", style: _getSerifStyle()),
              pw.Text(
                "Période couverte : ${transaction.description}",
                style: _getSerifStyle(),
              ),

              pw.SizedBox(height: 15),
              pw.Text(
                "Ce paiement contribue directement à l'entretien et à la valorisation de notre patrimoine commun. Merci.",
                style: _getSerifStyle(isItalic: true),
              ),

              pw.Spacer(),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  "Le Syndic",
                  style: _getSerifStyle(isBold: true),
                ),
              ),
              _buildFooter(), // Minimal footer
            ],
          ),
        ),
      ),
    );
    return _savePdf(pdf, 'recu_${transaction.id}.pdf');
  }

  // 4. CONVOCATION AG
  Future<File> generateConvocationAG(
    List<String> agendaItems,
    DateTime date,
    String location,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final dateStr = "${date.day}/${date.month}/${date.year}";
    final timeStr = "${date.hour}h${date.minute.toString().padLeft(2, '0')}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "CONVOCATION À L'ASSEMBLÉE GÉNÉRALE",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Décidons ensemble de notre cadre de vie",
                style: _getSerifStyle(fontSize: 12, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "Chers copropriétaires,",
              style: _getSerifStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Conformément à l'article 16 de la Loi 18-00, nous avons le plaisir de vous convoquer à l'Assemblée Générale Ordinaire qui se tiendra le :",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Date : $dateStr à $timeStr",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text("Lieu : $location", style: _getSerifStyle(isBold: true)),
            pw.SizedBox(height: 20),

            pw.Text(
              "ORDRE DU JOUR :",
              style: _getSerifStyle(isBold: true, fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            ...agendaItems.map(
              (item) => pw.Bullet(text: item, style: _getSerifStyle()),
            ),

            pw.SizedBox(height: 20),
            pw.Text(
              "Votre présence est cruciale pour atteindre le quorum légal. Si vous ne pouvez pas venir, merci de confier votre POUVOIR (ci-joint) à un voisin de confiance.",
              style: _getSerifStyle(),
            ),

            pw.Spacer(),
            pw.Text("Le Syndic.", style: _getSerifStyle(isBold: true)),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'convocation_ag.pdf');
  }

  // 5. POUVOIR
  Future<File> generatePouvoir(
    domain.Resident resident,
    DateTime agDate,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo(); // Small header
    final dateStr = "${agDate.day}/${agDate.month}/${agDate.year}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        margin: const pw.EdgeInsets.all(30),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logo != null)
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Image(logo, width: 30, height: 30),
              ),
            pw.Center(
              child: pw.Text(
                "POUVOIR DE REPRÉSENTATION (BON POUR POUVOIR)",
                style: _getSerifStyle(fontSize: 14, isBold: true),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "Assemblée Générale du $dateStr",
                style: _getSerifStyle(fontSize: 12),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "Je soussigné(e), Mr/Mme ${resident.name}, propriétaire de l'appartement n° ${resident.apartment},",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Ne pouvant assister à l'Assemblée Générale, donne par la présente POUVOIR à :",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              "Mr/Mme ________________________________________ (Nom du mandataire)",
              style: _getSerifStyle(isBold: true),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Pour me représenter, prendre part aux délibérations et voter en mon nom sur l'ensemble des résolutions portées à l'ordre du jour (Art. 15 Loi 18-00).",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              "Fait à _________________, le _________________.",
              style: _getSerifStyle(),
            ),

            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Column(
                children: [
                  pw.Text(
                    "Signature du Mandant",
                    style: _getSerifStyle(isBold: true),
                  ),
                  pw.Text(
                    "(précédée de la mention 'Bon pour pouvoir')",
                    style: _getSerifStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'pouvoir_${resident.id}.pdf');
  }

  // 6. PV
  Future<File> generatePV(
    DateTime date,
    int presentCount,
    int totalCount,
    int tantiemes,
    String quorumStatus,
    List<Map<String, dynamic>> resolutions,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final dateStr = "${date.day}/${date.month}/${date.year}";
    final year = date.year.toString();
    final day = date.day.toString();
    final month = date.month.toString();
    final timeStr = "${date.hour}h${date.minute.toString().padLeft(2, '0')}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "PROCÈS-VERBAL D'ASSEMBLÉE GÉNÉRALE",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "Résidence L'Amandier B - Séance du $dateStr",
                style: _getSerifStyle(fontSize: 12),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "L'an deux mille $year, le $day du mois de $month, à $timeStr, les copropriétaires se sont réunis sur convocation du Syndic.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Présents et représentés : $presentCount / $totalCount copropriétaires.",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Millièmes présents : $tantiemes/1000.",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Le Quorum (Art. 18) est-il atteint ? : $quorumStatus",
              style: _getSerifStyle(isBold: true),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "RÉSOLUTIONS VOTÉES :",
              style: _getSerifStyle(isBold: true, fontSize: 12),
            ),
            pw.SizedBox(height: 10),

            ...resolutions.map((res) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "* Résolution n°${res['id']} : ${res['title']}",
                      style: _getSerifStyle(isBold: true),
                    ),
                    pw.Text(
                      "  Vote : POUR (${res['votesFor']}) / CONTRE (${res['votesAgainst']}) / ABSTENTION (${res['votesAbstain']})",
                      style: _getSerifStyle(),
                    ),
                    pw.Text(
                      "  RÉSULTAT : ${res['status']} (Adoptée/Rejetée)",
                      style: _getSerifStyle(isBold: true),
                    ),
                  ],
                ),
              );
            }),

            pw.SizedBox(height: 20),
            pw.Text(
              "La séance est levée à [Heure Fin].",
              style: _getSerifStyle(),
            ),

            pw.Spacer(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Le Président de séance", style: _getSerifStyle()),
                pw.Text("Le Secrétaire", style: _getSerifStyle()),
                pw.Text("Le Syndic", style: _getSerifStyle()),
              ],
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'pv_ag.pdf');
  }

  // 7. CONTRAT CONCIERGE (CDI)
  Future<File> generateContratConcierge(
    String employeeName,
    String cin,
    double salaryAmount,
    int workHours,
    String dayOff,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "CONTRAT DE TRAVAIL À DURÉE INDÉTERMINÉE",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Conforme au Code du Travail & Loi sur les Gardiens d'Immeuble",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "ENTRE LES SOUSSIGNÉS :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Le Syndicat des Copropriétaires de la Résidence L'Amandier B, représenté par son Syndic.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),
            pw.Text("ET :", style: _getSerifStyle(isBold: true)),
            pw.Text(
              "M. $employeeName, titulaire de la CIN n° $cin.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "IL A ÉTÉ CONVENU CE QUI SUIT :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "ARTICLE 1 : ENGAGEMENT & FONCTIONS",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "M. $employeeName est engagé en qualité de Gardien-Concierge. Ses missions principales sont :",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Surveillance générale et filtrage des accès.",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text:
                  "Nettoyage des parties communes (Hall, escaliers, abords) selon planning.",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Gestion des poubelles et des espaces verts simples.",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Distribution du courrier et accueil des prestataires.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              "ARTICLE 2 : RÉMUNÉRATION & HORAIRES",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Le salarié percevra un salaire mensuel net de : ${salaryAmount.toStringAsFixed(2)} DH (Conforme SMIG en vigueur).",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Horaire de travail : $workHours heures/semaine, avec un jour de repos hebdomadaire le $dayOff.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              "ARTICLE 3 : AVANTAGES EN NATURE (EAU/ÉLECTRICITÉ)",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Le Syndicat prend en charge les factures d'eau et d'électricité de la loge, dans la limite d'une consommation raisonnable (\"Bon père de famille\"). Tout abus constaté (relevé compteur) pourra faire l'objet d'une retenue sur salaire après avertissement.",
              style: _getSerifStyle(),
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              "ARTICLE 4 : LOGEMENT DE FONCTION",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Un logement de service est mis à disposition (Voir \"Convention d'Occupation\" en annexe). Ce logement est un accessoire indissociable du contrat de travail. Il ne constitue pas un bail locatif.",
              style: _getSerifStyle(),
              textAlign: pw.TextAlign.justify,
            ),

            pw.Spacer(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text("Le Salarié", style: _getSerifStyle(isBold: true)),
                    pw.Text(
                      "(Lu et approuvé)",
                      style: _getSerifStyle(fontSize: 8),
                    ),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text("Le Syndic", style: _getSerifStyle(isBold: true)),
                    pw.Text(
                      "(Lu et approuvé)",
                      style: _getSerifStyle(fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'contrat_travail.pdf');
  }

  // 8. DECHARGE LOGEMENT (Anti-Squat)
  Future<File> generateDechargeLogement(
    String employeeName,
    DateTime date,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final dateStr = "${date.day}/${date.month}/${date.year}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "CONVENTION D'OCCUPATION DE LOGEMENT DE FONCTION",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Accessoire au Contrat de Travail",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "Je soussigné(e), M. $employeeName, reconnais que le logement situé à la loge de la Résidence L'Amandier B m'est attribué exclusivement pour l'exercice de mes fonctions de concierge.",
              style: _getSerifStyle(),
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "JE M'ENGAGE FORMELLEMENT À :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Bullet(
              text:
                  "Occuper les lieux personnellement (avec conjoint/enfants déclarés) en 'bon père de famille'.",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Ne pas sous-louer ni héberger de tiers.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              "RESTITUTION DES LIEUX :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Je reconnais expressément qu'en cas de rupture de mon contrat de travail, quelle qu'en soit la cause (démission, licenciement ou retraite), je devrai libérer les lieux et remettre les clés dans un délai de rigueur de HUIT (8) JOURS.",
              style: _getSerifStyle(),
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Passé ce délai, je reconnais être occupant sans droit ni titre et m'expose à une expulsion immédiate et à une indemnité d'occupation de 200 DH par jour de retard.",
              style: _getSerifStyle(),
              textAlign: pw.TextAlign.justify,
            ),

            pw.SizedBox(height: 30),
            pw.Text("Fait à Bouskoura, le $dateStr.", style: _getSerifStyle()),

            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                children: [
                  pw.Text("Le Gardien", style: _getSerifStyle(isBold: true)),
                  pw.Text(
                    "(Mention 'Lu et approuvé, bon pour accord')",
                    style: _getSerifStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'decharge_logement.pdf');
  }

  // 9. CONSENTEMENT DIGITAL (WhatsApp)
  Future<File> generateConsentementDigital(
    domain.Resident resident,
    String lotNumber,
    String phoneNumber,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "PROTOCOLE D'ACCORD DE DÉMATÉRIALISATION",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Acceptation des notifications électroniques (Loi 43-20)",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "Je soussigné(e), M./Mme ${resident.name}, copropriétaire du lot n° $lotNumber,",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),
            pw.Text(
              "Accepte expressément que toutes les notifications officielles du Syndic (Convocations AG, PV, Mises en demeure, Quittances) me soient transmises par voie électronique via :",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "L'application mobile 'Syndic L'Amandier B'.",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "La messagerie WhatsApp au numéro : $phoneNumber.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 20),

            pw.Text("JE RECONNAIS QUE :", style: _getSerifStyle(isBold: true)),
            pw.Bullet(
              text:
                  "La date de mise à disposition du document dans l'application fait foi pour le calcul des délais légaux (Loi 18-00).",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text:
                  "Les documents PDF signés électroniquement ont la même valeur probante que le papier (Loi 43-20).",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text:
                  "Je renonce à l'envoi papier par courrier recommandé pour privilégier la rapidité et l'écologie.",
              style: _getSerifStyle(),
            ),

            pw.SizedBox(height: 30),
            pw.Text(
              "Fait pour servir et valoir ce que de droit.",
              style: _getSerifStyle(),
            ),

            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Text(
                "Le Copropriétaire",
                style: _getSerifStyle(isBold: true),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'consentement_digital_${resident.id}.pdf');
  }

  // 10. BON DE COMMANDE
  Future<File> generateBonDeCommande(
    String poNumber,
    Map<String, dynamic> supplier,
    List<Map<String, dynamic>> items,
    String budgetLine,
    DateTime date,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final dateStr = "${date.day}/${date.month}/${date.year}";
    double total = 0;
    for (var i in items) {
      total += (i['qty'] as num) * (i['price'] as num);
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "BON DE COMMANDE N° $poNumber",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Engagement de Dépense - Résidence L'Amandier B",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text("FOURNISSEUR :", style: _getSerifStyle(isBold: true)),
            pw.Text(supplier['name'], style: _getSerifStyle()),
            pw.Text("ICE : ${supplier['ice']}", style: _getSerifStyle()),
            pw.SizedBox(height: 20),

            pw.Text(
              "DÉTAIL DE LA COMMANDE :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Le Syndic commande les travaux/fournitures suivants, conformément au devis n° ${supplier['quoteRef'] ?? 'N/A'} :",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            ...items.map(
              (item) => pw.Bullet(
                text:
                    "${item['name']} - Qté: ${item['qty']} - PU: ${item['price']} DH",
                style: _getSerifStyle(),
              ),
            ),

            pw.SizedBox(height: 20),
            pw.Text(
              "MONTANT TOTAL ESTIMÉ : ${total.toStringAsFixed(2)} DH",
              style: _getSerifStyle(isBold: true, fontSize: 12),
            ),
            pw.SizedBox(height: 20),

            pw.Text("CONDITIONS :", style: _getSerifStyle(isBold: true)),
            pw.Bullet(
              text:
                  "Imputation Budgétaire : $budgetLine (Conforme Décret 2.23.700).",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text:
                  "Facturation : La facture devra impérativement rappeler le N° de ce Bon de Commande.",
              style: _getSerifStyle(),
            ),

            pw.SizedBox(height: 20),
            pw.Text(
              "Validé par le Syndic le $dateStr.",
              style: _getSerifStyle(),
            ),

            pw.Spacer(),
            pw.Align(
              alignment: pw.Alignment.bottomRight,
              child: pw.Column(
                children: [
                  pw.Text("Le Syndic", style: _getSerifStyle(isBold: true)),
                  pw.Text(
                    "(Cachet et Signature)",
                    style: _getSerifStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'bon_commande_$poNumber.pdf');
  }

  // 11. BULLETIN DE PAIE (Bouclier Social)
  Future<File> generateBulletinPaieConcierge(
    String employeeName,
    String cin,
    int month,
    int year,
    double baseSalary,
    double overtime,
    double housingBenefit,
    double seniorityBonus,
    double cnssDeduction,
    double advances,
    String cnssRef,
    String paymentMethod,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final lastDay = DateTime(year, month + 1, 0).day;
    final netSalary =
        (baseSalary + overtime + seniorityBonus) - (cnssDeduction + advances);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "BULLETIN DE PAIE & REÇU DE SOLDE - MOIS DE $month/$year",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text(
                "Conforme au Code du Travail - Résidence L'Amandier B",
                style: _getSerifStyle(fontSize: 10, isItalic: true),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "EMPLOYEUR : Syndicat des Copropriétaires L'Amandier B.",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "SALARIÉ : M. $employeeName, CIN n° $cin.",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "PÉRIODE DE TRAVAIL : Du 01/$month au $lastDay/$month.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "DÉTAIL DE LA RÉMUNÉRATION :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Salaire de base (SMIG Horaire / Forfait) : ${baseSalary.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Heures supplémentaires (si validées) : ${overtime.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Avantage en nature (Logement & Eau/Elec) : Estimé à ${housingBenefit.toStringAsFixed(2)} DH (Pour info).",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Prime d'ancienneté (si applicable) : ${seniorityBonus.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text("A DÉDUIRE :", style: _getSerifStyle(isBold: true)),
            pw.Text(
              "Cotisation CNSS (Part salariale) : - ${cnssDeduction.toStringAsFixed(2)} DH (Réf Déclaration: $cnssRef)",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Avances sur salaire déjà perçues : - ${advances.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "NET À PAYER : ** ${netSalary.toStringAsFixed(2)} DH",
              style: _getSerifStyle(fontSize: 14, isBold: true),
            ),
            pw.SizedBox(height: 30),

            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "DÉCHARGE LÉGALE :",
                    style: _getSerifStyle(isBold: true),
                  ),
                  pw.Text(
                    "Je soussigné, M. $employeeName, reconnais avoir reçu la somme de **${netSalary.toStringAsFixed(2)} DH** par $paymentMethod pour solde de tout compte concernant le salaire du mois de $month/$year.",
                    style: _getSerifStyle(),
                  ),
                  pw.Text(
                    "Je donne quittance totale au Syndicat pour cette période.",
                    style: _getSerifStyle(),
                  ),
                ],
              ),
            ),

            pw.Spacer(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text("Le Salarié", style: _getSerifStyle(isBold: true)),
                    pw.Text(
                      "(Mention 'Lu et approuvé, reçu en mains propres')",
                      style: _getSerifStyle(fontSize: 8),
                    ),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text("Le Syndic", style: _getSerifStyle(isBold: true)),
                    pw.Text("(Signature)", style: _getSerifStyle(fontSize: 8)),
                  ],
                ),
              ],
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(
      pdf,
      'bulletin_paie_${employeeName.replaceAll(' ', '_')}_$month.pdf',
    );
  }

  // 12. RECU PRESTATION MENAGE (Service Proof) - Fixed Identifier Name (Recu instead of Reçu)
  Future<File> generateRecuPrestationMenage(
    String cleanerName,
    String cin,
    String interventionDates,
    double hours,
    double rate,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final total = hours * rate;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5.landscape,
        margin: const pw.EdgeInsets.all(30),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logo != null) pw.Image(logo, width: 40, height: 40),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      "REÇU DE PRESTATION DE SERVICE",
                      style: _getSerifStyle(fontSize: 14, isBold: true),
                    ),
                    pw.Text(
                      "Justificatif de Dépenses - Entretien",
                      style: _getSerifStyle(fontSize: 10, isItalic: true),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              "PRESTATAIRE : Mme/Mlle $cleanerName, CIN n° $cin.",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "CLIENT : Syndicat des Copropriétaires L'Amandier B.",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text(
              "OBJET DE LA PRESTATION :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Nettoyage et entretien des parties communes (Escaliers, Hall, Parking).",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 10),

            pw.Text("DÉTAIL :", style: _getSerifStyle(isBold: true)),
            pw.Bullet(
              text: "Dates d'intervention : $interventionDates",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Nombre d'heures/Jours : $hours",
              style: _getSerifStyle(),
            ),
            pw.Bullet(
              text: "Tarif convenu : $rate DH",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "MONTANT TOTAL PERÇU : ** ${total.toStringAsFixed(2)} DH",
              style: _getSerifStyle(fontSize: 14, isBold: true),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Je certifie avoir effectué ces prestations de manière indépendante et avoir reçu le paiement complet ce jour.",
              style: _getSerifStyle(isItalic: true),
            ),

            pw.Spacer(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "L'Intervenant(e)",
                  style: _getSerifStyle(isBold: true),
                ),
                pw.Text("Le Syndic", style: _getSerifStyle(isBold: true)),
              ],
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'recu_menage.pdf');
  }

  // 13. JOURNAL CAISSE (Treasury Snapshot)
  Future<File> generateJournalCaisse(
    double bankStart,
    double bankIn,
    double bankOut,
    double cashBalance,
    double reserveFund,
    double pendingInvoices,
    double unpaidDebts,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();
    final date = DateTime.now();
    final dateStr = "${date.day}/${date.month}/${date.year}";
    final bankBalance = bankStart + bankIn - bankOut;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logo),
            pw.Center(
              child: pw.Text(
                "SITUATION DE TRÉSORERIE INSTANTANÉE",
                style: _getSerifStyle(fontSize: 16, isBold: true),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "Arrêté au $dateStr",
                style: _getSerifStyle(fontSize: 12),
              ),
            ),
            pw.SizedBox(height: 30),

            pw.Text(
              "ÉTAT DES COMPTES (CLASSE 5 - DÉCRET 2.23.700) :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "1. BANQUE (Compte Principal) :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Solde début de mois : ${bankStart.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "Total Encaissements (Virements reçus) : + ${bankIn.toStringAsFixed(2)} DH",
              style: _getSerifStyle(color: PdfColors.green),
            ),
            pw.Text(
              "Total Décaissements (Chèques/Virements émis) : - ${bankOut.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.Text(
              "SOLDE ACTUEL : ${bankBalance.toStringAsFixed(2)} DH",
              style: _getSerifStyle(isBold: true),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "2. CAISSE (Espèces - Menues dépenses) :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Solde actuel : ${cashBalance.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 15),

            pw.Text(
              "3. FONDS DE TRAVAUX (Réserve) :",
              style: _getSerifStyle(isBold: true),
            ),
            pw.Text(
              "Montant sanctuarisé : ${reserveFund.toStringAsFixed(2)} DH",
              style: _getSerifStyle(),
            ),
            pw.SizedBox(height: 20),

            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("4. ALERTES :", style: _getSerifStyle(isBold: true)),
                  pw.Text(
                    "Factures fournisseurs en attente de paiement : ${pendingInvoices.toStringAsFixed(2)} DH",
                    style: _getSerifStyle(),
                  ),
                  pw.Text(
                    "Impayés copropriétaires critiques (> 3 mois) : ${unpaidDebts.toStringAsFixed(2)} DH",
                    style: _getSerifStyle(),
                  ),
                ],
              ),
            ),

            pw.Spacer(),
            pw.Text(
              "Certifié conforme par le système d'automatisation.",
              style: _getSerifStyle(isItalic: true),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'journal_caisse.pdf');
  }

  // 14. TABLEAU ANNUEL (Global Matrix)
  Future<File> generateGlobalMatrix(
    List<domain.Resident> residents,
    Map<int, Map<int, bool>> paymentMatrix,
    int year,
  ) async {
    final pdf = pw.Document();
    final logo = await _loadLogo();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                if (logo != null) pw.Image(logo, width: 40, height: 40),
                pw.Text(
                  "ÉTAT DES COTISATIONS - ANNÉE $year",
                  style: _getSerifStyle(fontSize: 16, isBold: true),
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            pw.Table(
              border: pw.TableBorder.all(width: 0.5),
              children: [
                // Header Row
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        "Résident",
                        style: _getSerifStyle(isBold: true, fontSize: 10),
                      ),
                    ),
                    ...List.generate(
                      12,
                      (index) => pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "${index + 1}",
                          style: _getSerifStyle(isBold: true, fontSize: 10),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                // Data Rows
                ...residents.map((r) {
                  final residentPayments = paymentMatrix[r.id] ?? {};
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          r.name,
                          style: _getSerifStyle(fontSize: 9),
                        ),
                      ),
                      ...List.generate(12, (monthIndex) {
                        final isPaid =
                            residentPayments[monthIndex + 1] ?? false;
                        return pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            isPaid ? "X" : "",
                            style: _getSerifStyle(isBold: true, fontSize: 10),
                            textAlign: pw.TextAlign.center,
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),

            pw.Spacer(),
            pw.Text(
              "Légende : X = Payé. Vide = Impayé.",
              style: _getSerifStyle(isItalic: true, fontSize: 10),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
    return _savePdf(pdf, 'tableau_annuel_$year.pdf');
  }
}
