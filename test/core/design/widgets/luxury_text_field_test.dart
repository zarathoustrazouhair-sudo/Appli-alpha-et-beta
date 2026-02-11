import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/design/widgets/luxury_text_field.dart';

void main() {
  testWidgets('LuxuryTextField displays label and hint', (WidgetTester tester) async {
    const label = 'Test Label';
    const hint = 'Test Hint';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LuxuryTextField(
            label: label,
            hint: hint,
          ),
        ),
      ),
    );

    expect(find.text(label.toUpperCase()), findsOneWidget);
    expect(find.text(hint), findsOneWidget);
  });

  testWidgets('LuxuryTextField autofocus and onFieldSubmitted', (WidgetTester tester) async {
    bool submitted = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LuxuryTextField(
            label: 'Test',
            autofocus: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) {
              submitted = true;
            },
          ),
        ),
      ),
    );

    // Verify autofocus
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    final textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.autofocus, isTrue);

    // Verify onFieldSubmitted
    await tester.enterText(textFieldFinder, 'Input');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(submitted, isTrue);
  });
}
