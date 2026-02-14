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

    testWidgets('Clear button appears when text is entered and clears text on tap', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxuryTextField(
              label: 'Test Label',
              controller: controller,
            ),
          ),
        ),
      );

      // Initially no clear button (text is empty)
      expect(find.byIcon(Icons.close), findsNothing);

      // Enter text
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pump();

      // Clear button should appear
      final clearButtonFinder = find.byIcon(Icons.close);
      expect(clearButtonFinder, findsOneWidget);

      // Tap clear button
      await tester.tap(clearButtonFinder);
      await tester.pump();

      // Text should be cleared
      expect(controller.text, isEmpty);
      // Clear button should disappear
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('Password toggle works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxuryTextField(
              label: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final textFieldFinder = find.byType(TextField);
      final textField = tester.widget<TextField>(textFieldFinder);

      // Initially obscured
      expect(textField.obscureText, isTrue);

      // Toggle button should be visible (icon: visibility)
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Tap toggle
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      // Should be revealed
      final textFieldRevealed = tester.widget<TextField>(textFieldFinder);
      expect(textFieldRevealed.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });
  });
}
