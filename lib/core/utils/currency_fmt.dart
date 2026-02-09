import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _currency = NumberFormat.currency(
    locale: 'fr_MA',
    symbol: 'DH',
    decimalDigits: 2,
  );

  static String format(double value) {
    return _currency.format(value);
  }
}
