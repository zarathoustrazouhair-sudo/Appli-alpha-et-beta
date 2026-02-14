## 2024-05-22 - Focus Management in Custom Inputs
**Learning:** Custom input widgets (like `LuxuryTextField`) must explicitly manage focus restoration after secondary actions (like clearing text).
**Action:** When implementing clear buttons or similar inline actions, always call `focusNode.requestFocus()` to keep the keyboard active and maintain user flow.
