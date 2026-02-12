## 2024-05-23 - Custom Widget Semantics
**Learning:** When creating custom semantic labels for widgets that contain text (like `ApartmentGrid` cells), the internal text semantics are often appended to the custom label, creating redundancy (e.g., "Apartment 1, Up to date, AP1").
**Action:** Always use `excludeSemantics: true` in the parent `Semantics` widget to cleanly replace the child's semantics with the custom label.
