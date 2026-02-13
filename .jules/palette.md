## 2024-05-23 - Custom Widget Semantics
**Learning:** When creating custom semantic labels for widgets that contain text (like `ApartmentGrid` cells), the internal text semantics are often appended to the custom label, creating redundancy (e.g., "Apartment 1, Up to date, AP1").
**Action:** Always use `excludeSemantics: true` in the parent `Semantics` widget to cleanly replace the child's semantics with the custom label.

## 2024-05-24 - Tooltip and Icon Semantics
**Learning:** `Tooltip` widgets in Flutter provide implicit `Semantics`, but they do not automatically silence the internal semantics of their children (e.g., an Icon's name). This can lead to screen readers announcing both the tooltip message and the icon name (e.g., "Financial Health Excellent, sentiment very satisfied").
**Action:** When wrapping a visual-only widget (like an Icon) in a `Tooltip` for accessibility, wrap the child in `Semantics(excludeSemantics: true, ...)` to ensure only the meaningful tooltip message is announced.

## 2024-05-25 - Loading State Semantics
**Learning:** Visual-only indicators like spinners (e.g., in buttons) are invisible to screen readers, leaving users with a disabled button and no context.
**Action:** Always wrap loading indicators in `Semantics(label: 'Loading...', child: ...)` to ensure the state change is announced, even if the parent button is disabled.
