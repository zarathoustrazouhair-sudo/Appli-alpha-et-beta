import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/features/finance/domain/usecases/calculate_paid_until_usecase.dart';

void main() {
  group('CalculatePaidUntilUseCase', () {
    late CalculatePaidUntilUseCase useCase;
    // Fix current date for testing: 1st Feb 2026
    final fixedDate = DateTime(2026, 2, 1);

    setUp(() {
      useCase = CalculatePaidUntilUseCase();
    });

    test('returns "EN RETARD" for negative balance', () {
      final result = useCase.execute(-250.0, currentDate: fixedDate);
      expect(result, "EN RETARD");
    });

    test('returns current month for 0 balance (exact match)', () {
      // Balance 0 means paid up to date (current month included?)
      // Logic implemented: monthsAdvance = 0. FutureDate = Current.
      final result = useCase.execute(0.0, currentDate: fixedDate);
      expect(result, "Payé jusqu'à FÉVRIER 2026");
    });

    test('returns future date for positive balance (2 months advance)', () {
      // 500 / 250 = 2 months.
      // Feb + 2 months = April.
      final result = useCase.execute(500.0, currentDate: fixedDate);
      expect(result, "Payé jusqu'à AVRIL 2026");
    });

    test('returns future date for partial positive balance (round down)', () {
      // 300 / 250 = 1.2 -> 1 month.
      // Feb + 1 = March.
      final result = useCase.execute(300.0, currentDate: fixedDate);
      expect(result, "Payé jusqu'à MARS 2026");
    });
  });
}
