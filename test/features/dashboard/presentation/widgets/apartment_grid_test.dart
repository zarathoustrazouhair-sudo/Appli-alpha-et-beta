import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/features/dashboard/presentation/widgets/apartment_grid.dart';

void main() {
  testWidgets('ApartmentGrid has correct semantics and tooltips', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ApartmentGrid(),
        ),
      ),
    );

    // Verify Semantics for Apartment 1 (Odd -> Paid -> Up to date)
    final finder1 = find.bySemanticsLabel('Apartment 1, Up to date');
    expect(finder1, findsOneWidget);

    final semantics1 = tester.getSemantics(finder1);
    expect(semantics1.hint, 'Double tap to view details');
    expect(semantics1.hasFlag(SemanticsFlag.isButton), isTrue);

    // Verify Semantics for Apartment 2 (Even -> Debt -> Payment Overdue)
    final finder2 = find.bySemanticsLabel('Apartment 2, Payment Overdue');
    expect(finder2, findsOneWidget);

    final semantics2 = tester.getSemantics(finder2);
    expect(semantics2.hint, 'Double tap to view details');
    expect(semantics2.hasFlag(SemanticsFlag.isButton), isTrue);

    // Verify Tooltips are present (Tooltip widget wraps the content)
    expect(find.byTooltip('Apartment 1, Up to date'), findsOneWidget);
    expect(find.byTooltip('Apartment 2, Payment Overdue'), findsOneWidget);
  });
}
