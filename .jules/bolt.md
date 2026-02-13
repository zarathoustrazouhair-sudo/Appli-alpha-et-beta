## 2024-05-22 - [Hidden Cost of Glassmorphism]
**Learning:** `BackdropFilter` is expensive on the GPU. Applying it on top of a solid background (e.g., `Scaffold` color) is redundant and wastes resources. We found `LuxuryCard` in `luxury_widgets.dart` had `withBlur: true` by default, causing unnecessary blurs in lists and charts.
**Action:** Use optimized widgets without blur (`widgets/luxury_card.dart`) for solid backgrounds or lists. Audit custom widgets for expensive default parameters.
