import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syndic_pro/features/settings/presentation/about_screen.dart';

void main() {
  testWidgets('AboutScreen renders correctly with required text and logo', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));

    // Verify the title "L'ARCHITECTE DES OMBRES" is present.
    expect(find.text("L'ARCHITECTE DES OMBRES"), findsOneWidget);

    // Verify the footer "Version Prestige 2.0" is present (part of multiline text).
    expect(
      find.text(
        "Conçu pour la Résidence L'Amandier B.\nVersion Prestige 2.0.\n\nOptimisation. Sécurité. Transparence.",
      ),
      findsOneWidget,
    );

    // Verify the security icon is present.
    expect(find.byIcon(Icons.security), findsOneWidget);
  });
}
