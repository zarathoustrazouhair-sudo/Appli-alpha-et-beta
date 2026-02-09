import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfStyles {
  static final headerStyle = pw.TextStyle(
    fontSize: 20,
    fontWeight: pw.FontWeight.bold,
  );

  static final subHeaderStyle = pw.TextStyle(
    fontSize: 16,
    fontWeight: pw.FontWeight.bold,
  );

  static final tableHeaderStyle = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
  );

  static final tableRowStyle = pw.TextStyle(
    fontSize: 10,
  );

  static final footerStyle = pw.TextStyle(
    fontSize: 10,
    color: PdfColors.grey700,
  );
}
