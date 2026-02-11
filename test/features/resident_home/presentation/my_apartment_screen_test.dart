import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amandier_b/features/resident_home/presentation/my_apartment_screen.dart';

void main() {
  testWidgets('MyApartmentScreen renders correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: MyApartmentScreen()));

    // Verify header
    expect(find.text('Bonjour M. Résident'), findsOneWidget);
    expect(find.text('0.00 MAD'), findsOneWidget);

    // Verify SOS button
    expect(find.text('GLISSER POUR SOS'), findsOneWidget);

    // Verify Blog List
    expect(find.text('Derniers Articles'), findsOneWidget);
    expect(find.text('Article Blog 1'), findsOneWidget);
    expect(find.text('Article Blog 2'), findsOneWidget);
    expect(find.text('Article Blog 3'), findsOneWidget);

    // Verify FAB
    expect(find.byIcon(Icons.report_problem), findsOneWidget);
  });
}
