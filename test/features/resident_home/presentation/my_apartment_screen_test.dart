import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:amandier_b/features/resident_home/presentation/my_apartment_screen.dart';

void main() {
  testWidgets('MyApartmentScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyApartmentScreen()));

    expect(find.text('Mon Appartement'), findsOneWidget);
    expect(find.text('Bonjour M. Résident'), findsOneWidget);
    expect(find.text('GLISSER POUR SOS'), findsOneWidget);
    expect(find.text('Derniers Articles'), findsOneWidget);
    expect(find.text('Article Blog 1'), findsOneWidget);
  });
}
