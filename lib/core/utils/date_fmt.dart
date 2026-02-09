import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'fr_FR');
  static final DateFormat _shortDateFormat = DateFormat('dd/MM/yyyy', 'fr_FR');

  static String format(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatShort(DateTime date) {
    return _shortDateFormat.format(date);
  }
}
