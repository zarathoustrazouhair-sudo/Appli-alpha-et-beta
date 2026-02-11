## 2024-05-23 - Accessibility Testing in Flutter
**Learning:** Testing `Semantics` in Flutter widget tests can be tricky. `find.bySemanticsLabel` relies on the semantic tree which needs `tester.ensureSemantics()` and may require specific finder configurations.
**Action:** Use `find.byWidgetPredicate` to verify the `Semantics` widget structure directly for robustness, and combine it with functional tests (e.g., `tester.tap` or `tester.drag` on the target widget) to verify the interaction logic.
