## 2024-05-22 - [MyApartmentScreen Optimization]
**Learning:** Found `ListView.builder` with `shrinkWrap: true` inside `SingleChildScrollView` used for a small static list. This forces a layout pass on all children, negating `ListView` benefits and adding overhead.
**Action:** Replaced with `Column` and `...List.generate` (or map) when the list is small and nested in a scroll view. Also extracted helper methods to `const` widgets to reduce rebuilds.
