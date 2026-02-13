## 2024-05-22 - [Hidden Cost of Glassmorphism]
**Learning:** `BackdropFilter` is expensive on the GPU. Applying it on top of a solid background (e.g., `Scaffold` color) is redundant and wastes resources. We found `LuxuryCard` in `luxury_widgets.dart` had `withBlur: true` by default, causing unnecessary blurs in lists and charts.
**Action:** Use optimized widgets without blur (`widgets/luxury_card.dart`) for solid backgrounds or lists. Audit custom widgets for expensive default parameters.

## 2024-05-23 - [Redundant Alpha Blending]
**Learning:** Applying a semi-transparent color (e.g., `withOpacity(0.8)`) on top of the SAME solid background color is visually identical to using the solid color but forces the GPU to perform expensive alpha blending calculations for every pixel.
**Action:** When a card or container is always on a specific background color, use the opaque color instead of `withOpacity` to save GPU cycles, especially in lists.
