import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/theme/widgets/financial_mood_icon.dart';

void main() {
  group('FinancialMoodIcon Accessibility Tests', () {
    testWidgets('Should display correct semantic label for Green status (> 3 months)', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: 4.5),
        ),
      ));

      expect(find.byType(FinancialMoodIcon), findsOneWidget);
      // Semantics check
      expect(find.bySemanticsLabel('Santé financière excellente'), findsOneWidget);
      // Tooltip check (Tooltip widget creates a Semantics node with the message as label too, but let's check for Tooltip widget specifically if possible, or just the behavior)
      expect(find.byTooltip('Santé financière excellente'), findsOneWidget);
    });

    testWidgets('Should display correct semantic label for Orange status (> 0 months)', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: 1.5),
        ),
      ));

      expect(find.byType(FinancialMoodIcon), findsOneWidget);
      expect(find.bySemanticsLabel('Santé financière stable'), findsOneWidget);
      expect(find.byTooltip('Santé financière stable'), findsOneWidget);
    });

    testWidgets('Should display correct semantic label for Red status (< 0 months)', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: -1.0),
        ),
      ));

      expect(find.byType(FinancialMoodIcon), findsOneWidget);
      expect(find.bySemanticsLabel('Santé financière critique'), findsOneWidget);
      expect(find.byTooltip('Santé financière critique'), findsOneWidget);
    });
  });
}
