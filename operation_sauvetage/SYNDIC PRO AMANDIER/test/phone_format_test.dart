import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/core/utils/formatters.dart';

void main() {
  group('Formatters.formatWhatsAppNumber', () {
    test('Local Moroccan format starting with 0', () {
      expect(Formatters.formatWhatsAppNumber('0612345678'), '212612345678');
    });

    test('International Moroccan format starting with 212', () {
      expect(Formatters.formatWhatsAppNumber('212612345678'), '212612345678');
    });

    test('International Moroccan format with +', () {
      expect(Formatters.formatWhatsAppNumber('+212612345678'), '212612345678');
    });

    test('Moroccan format with spaces and dashes', () {
      expect(Formatters.formatWhatsAppNumber('+212 6-12 34 56 78'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('06 12 34 56 78'), '212612345678');
    });

    test('9-digit local Moroccan format', () {
      expect(Formatters.formatWhatsAppNumber('612345678'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('712345678'), '212712345678');
      expect(Formatters.formatWhatsAppNumber('512345678'), '212512345678');
    });

    test('International French number', () {
      expect(Formatters.formatWhatsAppNumber('+33612345678'), '33612345678');
    });

    test('Empty input', () {
      expect(Formatters.formatWhatsAppNumber(''), '');
    });

    test('Malformed input - too short', () {
      expect(Formatters.formatWhatsAppNumber('123'), '123');
    });

    test('Malformed input - numeric but weird', () {
      // 9 digits not starting with 5, 6, 7. Fallback assumes Moroccan for now.
      expect(Formatters.formatWhatsAppNumber('123456789'), '212123456789');
    });
  });
}
