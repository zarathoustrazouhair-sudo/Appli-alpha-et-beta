import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:residence_lamandier_b/core/theme/widgets/luxury_text_field.dart';

void main() {
  group('LuxuryTextField Tests', () {
    testWidgets('autofocus requests focus', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxuryTextField(
              label: 'Test Label',
              autofocus: true,
            ),
          ),
        ),
      );

      // Verify that the text field has focus
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      final textField = tester.widget<TextField>(textFieldFinder);
      expect(textField.autofocus, isTrue);
    });

    testWidgets('onFieldSubmitted callback is triggered', (WidgetTester tester) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryTextField(
              label: 'Test Label',
              onFieldSubmitted: (value) {
                submittedValue = value;
              },
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test Value');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Verify callback
      expect(submittedValue, 'Test Value');
    });

    testWidgets('textInputAction is passed to TextField', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxuryTextField(
              label: 'Test Label',
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textInputAction, TextInputAction.next);
    });
  });
}
