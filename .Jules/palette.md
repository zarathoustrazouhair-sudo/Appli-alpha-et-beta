## 2024-05-22 - Design System Wrapper Trap
**Learning:** Wrapping standard Flutter widgets (like `TextFormField`) in custom "Luxury" widgets without exposing core interactivity props (autofocus, textInputAction, onFieldSubmitted) kills keyboard usability.
**Action:** When creating design system components, always expose standard interaction callbacks or use a composition pattern that allows access to the underlying widget's capabilities.
