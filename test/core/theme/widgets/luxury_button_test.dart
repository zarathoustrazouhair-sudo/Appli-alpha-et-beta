import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/theme/widgets/luxury_button.dart';

void main() {
  group('LuxuryButton Tests', () {
    testWidgets('Displays label in normal state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryButton(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('TEST BUTTON'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Displays loader in loading state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryButton(
              label: 'Test Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('TEST BUTTON'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Has semantic label in loading state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryButton(
              label: 'Test Button',
              onPressed: () {},
              isLoading: true,
              // We expect the default or a custom label. Let's assume default for now.
            ),
          ),
        ),
      );

      // Verify that there is a Semantics node with label 'Chargement...'
      // Note: Since the button is disabled, the semantics might be tricky to find directly on the button if not handled correctly.
      // We look for any widget with label 'Chargement...'.
      expect(find.bySemanticsLabel('Chargement...'), findsOneWidget);
    });
  });
}
