import 'package:pdf/pdf.dart';

class Formatters {
  static String formatMoney(double amount) {
    return '${amount.toStringAsFixed(2)} DH';
  }

  static PdfColor getContrastColor(double balance) {
    if (balance < 0) return PdfColors.white;
    return PdfColors.black;
  }

  static PdfColor getBackgroundColor(double balance) {
    if (balance < 0) return PdfColors.black;
    return PdfColors.white;
  }

  static String formatWhatsAppNumber(String phone) {
    if (phone.isEmpty) return '';

    // Remove all non-numeric characters
    var number = phone.replaceAll(RegExp(r'\D'), '');

    // Case 1: Already has 212 and seems complete (12 digits: 212 + 9 digits)
    if (number.startsWith('212') && number.length == 12) {
      return number;
    }

    // Case 2: Local format starting with 0 (e.g. 0612345678 -> 10 digits)
    if (number.startsWith('0') && number.length == 10) {
      return '212${number.substring(1)}';
    }

    // Case 3: 9 digits starting with 5, 6, or 7 (Moroccan local without 0)
    if (number.length == 9 &&
        (number.startsWith('5') ||
            number.startsWith('6') ||
            number.startsWith('7'))) {
      return '212$number';
    }

    // Case 4: If it's already an international number (not starting with 0, length > 10)
    // We just return it as is (after sanitization)
    if (number.length > 10) {
      return number;
    }

    // Fallback: if it's 9 digits and doesn't match above, we still assume Moroccan for this context
    if (number.length == 9) {
      return '212$number';
    }

    return number;
  }

  static String amountToWords(double amount) {
    int n = amount.floor();
    if (n == 0) return 'Zéro';
    return _convert(n);
  }

  static final List<String> _units = [
    '',
    'Un',
    'Deux',
    'Trois',
    'Quatre',
    'Cinq',
    'Six',
    'Sept',
    'Huit',
    'Neuf',
    'Dix',
    'Onze',
    'Douze',
    'Treize',
    'Quatorze',
    'Quinze',
    'Seize',
    'Dix-sept',
    'Dix-huit',
    'Dix-neuf',
  ];

  static String _convert(int n) {
    if (n < 20) return _units[n];

    if (n < 100) {
      int ten = n ~/ 10;
      int unit = n % 10;

      if (n == 20) return 'Vingt';
      if (n == 30) return 'Trente';
      if (n == 40) return 'Quarante';
      if (n == 50) return 'Cinquante';
      if (n == 60) return 'Soixante';
      if (n == 70) return 'Soixante-dix';
      if (n == 80) return 'Quatre-vingts';
      if (n == 90) return 'Quatre-vingt-dix';

      // 71-79
      if (ten == 7) {
        if (unit == 1) return 'Soixante-et-Onze';
        return 'Soixante-${_units[10 + unit]}';
      }

      // 91-99
      if (ten == 9) {
        return 'Quatre-vingt-${_units[10 + unit]}';
      }

      // 81-89
      if (ten == 8) {
        if (unit == 1) return 'Quatre-vingt-Un';
        return 'Quatre-vingt-${_units[unit]}';
      }

      // 21, 31, 41, 51, 61
      if (unit == 1) {
        if (ten == 2) return 'Vingt-et-Un';
        if (ten == 3) return 'Trente-et-Un';
        if (ten == 4) return 'Quarante-et-Un';
        if (ten == 5) return 'Cinquante-et-Un';
        if (ten == 6) return 'Soixante-et-Un';
      }

      // Standard tens (22-29, 32-39, etc)
      String tenStr = '';
      if (ten == 2) {
        tenStr = 'Vingt';
      } else if (ten == 3)
        tenStr = 'Trente';
      else if (ten == 4)
        tenStr = 'Quarante';
      else if (ten == 5)
        tenStr = 'Cinquante';
      else if (ten == 6)
        tenStr = 'Soixante';

      return '$tenStr-${_units[unit]}';
    }

    if (n < 1000) {
      int hundred = n ~/ 100;
      int rest = n % 100;

      String hStr = (hundred == 1) ? 'Cent' : '${_units[hundred]} Cents';

      if (rest == 0) return hStr;

      // Remove 's' if not exact hundred
      if (hStr.endsWith('s')) hStr = hStr.substring(0, hStr.length - 1);

      return '$hStr ${_convert(rest)}';
    }

    if (n < 1000000) {
      int thousand = n ~/ 1000;
      int rest = n % 1000;

      String tStr = (thousand == 1) ? 'Mille' : '${_convert(thousand)} Mille';

      if (rest == 0) return tStr;
      return '$tStr ${_convert(rest)}';
    }

    return n.toString();
  }
}
