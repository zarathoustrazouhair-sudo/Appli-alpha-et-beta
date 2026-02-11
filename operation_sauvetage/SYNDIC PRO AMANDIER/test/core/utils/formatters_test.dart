import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/core/utils/formatters.dart';

void main() {
  group('Formatters', () {
    test('formatWhatsAppNumber formats correctly', () {
      expect(Formatters.formatWhatsAppNumber('0612345678'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('612345678'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('212612345678'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('+212 6 12 34 56 78'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('06-12-34-56-78'), '212612345678');
      expect(Formatters.formatWhatsAppNumber('05 22 12 34 56'), '212522123456');
    });
  });
}
