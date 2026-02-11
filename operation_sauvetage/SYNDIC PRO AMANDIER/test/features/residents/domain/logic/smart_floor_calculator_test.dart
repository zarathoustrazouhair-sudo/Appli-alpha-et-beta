import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/features/residents/domain/logic/smart_floor_calculator.dart';

void main() {
  group('SmartFloorCalculator', () {
    test('returns "1er Étage" for apartments 1-5', () {
      expect(SmartFloorCalculator.getFloor(1), "1er Étage");
      expect(SmartFloorCalculator.getFloor(5), "1er Étage");
    });

    test('returns "2ème Étage" for apartments 6-10', () {
      expect(SmartFloorCalculator.getFloor(6), "2ème Étage");
      expect(SmartFloorCalculator.getFloor(10), "2ème Étage");
    });

    test('returns "3ème Étage" for apartments 11-15', () {
      expect(SmartFloorCalculator.getFloor(11), "3ème Étage");
      expect(SmartFloorCalculator.getFloor(15), "3ème Étage");
    });

    test('returns "RDC ou Inconnu" for other numbers', () {
      expect(SmartFloorCalculator.getFloor(0), "RDC ou Inconnu");
      expect(SmartFloorCalculator.getFloor(16), "RDC ou Inconnu");
    });
  });
}
