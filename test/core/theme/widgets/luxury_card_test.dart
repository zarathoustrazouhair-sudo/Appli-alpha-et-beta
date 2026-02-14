import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/theme/widgets/luxury_card.dart';

void main() {
  group('LuxuryCard Tests', () {
    testWidgets('Renders child content correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LuxuryCard(child: Text('Test Content'))),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('Applies custom padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(32);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxuryCard(
              padding: customPadding,
              child: Text('Test Content'),
            ),
          ),
        ),
      );

      final paddingWidget = tester.widget<Padding>(
        find
            .ancestor(
              of: find.text('Test Content'),
              matching: find.byType(Padding),
            )
            .first,
      );
      expect(paddingWidget.padding, customPadding);
    });

    testWidgets('Responds to tap when onTap is provided', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(LuxuryCard));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Has accessibility traits when interactive', (
      WidgetTester tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryCard(
              onTap: () {},
              child: const Text('Interactive Card'),
            ),
          ),
        ),
      );

      // Verify that the interactive card has button semantics
      final semantics = tester.getSemantics(find.byType(InkWell));
      final data = semantics.getSemanticsData();

      expect(
        data.hasFlag(SemanticsFlag.isButton),
        isTrue,
        reason: 'Should be a button',
      );
      expect(
        data.hasAction(SemanticsAction.tap),
        isTrue,
        reason: 'Should be tappable',
      );
      expect(
        data.hasFlag(SemanticsFlag.isFocusable),
        isTrue,
        reason: 'Should be focusable',
      );
      expect(data.label, 'Interactive Card');

      handle.dispose();
    });

    testWidgets('Does NOT have button trait when NOT interactive', (
      WidgetTester tester,
    ) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LuxuryCard(child: Text('Static Card'))),
        ),
      );

      // Verify the semantics node for the static card does NOT have button traits
      final semantics = tester.getSemantics(find.byType(InkWell));
      final data = semantics.getSemanticsData();

      expect(
        data.hasFlag(SemanticsFlag.isButton),
        isFalse,
        reason: 'Should NOT be a button',
      );
      expect(
        data.hasAction(SemanticsAction.tap),
        isFalse,
        reason: 'Should NOT be tappable',
      );
      expect(data.label, 'Static Card');
      expect(
        data.hasFlag(SemanticsFlag.isEnabled),
        isFalse,
        reason: 'Should be disabled',
      );

      handle.dispose();
    });
  });
}
