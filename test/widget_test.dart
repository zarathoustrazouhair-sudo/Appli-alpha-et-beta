import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amandier_b/main.dart';

void main() {
  testWidgets('App starts at Cockpit (Syndic default)', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    expect(find.text('Cockpit Syndic'), findsOneWidget);
  });
}
