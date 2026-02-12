import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/theme/widgets/financial_mood_icon.dart';
import 'package:residence_lamandier_b/core/theme/luxury_theme.dart';

void main() {
  testWidgets('FinancialMoodIcon displays correct icon and color for happy state', (WidgetTester tester) async {
    // Case 1: Happy State (>= 3.0)
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: 3.0),
        ),
      ),
    );

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.icon, Icons.sentiment_very_satisfied);
    expect(icon.color, const Color(0xFF00E5FF));
    expect(icon.size, 24.0); // Default size
  });

  testWidgets('FinancialMoodIcon displays correct icon and color for neutral state', (WidgetTester tester) async {
    // Case 2: Neutral State (0.0 to < 3.0)
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: 1.5),
        ),
      ),
    );

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.icon, Icons.sentiment_neutral);
    expect(icon.color, const Color(0xFFFFAB00));
  });

  testWidgets('FinancialMoodIcon displays correct icon and color for panic state', (WidgetTester tester) async {
    // Case 3: Panic State (< 0.0)
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: -1.0),
        ),
      ),
    );

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.icon, Icons.add_alert);
    expect(icon.color, AppTheme.errorRed);
  });

  testWidgets('FinancialMoodIcon respects custom size', (WidgetTester tester) async {
    // Case 4: Custom Size
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FinancialMoodIcon(monthsOfSurvival: 3.0, size: 48.0),
        ),
      ),
    );

    final iconFinder = find.byType(Icon);
    expect(iconFinder, findsOneWidget);

    final Icon icon = tester.widget(iconFinder);
    expect(icon.size, 48.0);
  });
}
