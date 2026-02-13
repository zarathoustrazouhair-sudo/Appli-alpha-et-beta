class AppValidators {
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$",
  );
  static final RegExp _letterRegex = RegExp(r'[a-zA-Z]');
  static final RegExp _numberRegex = RegExp(r'[0-9]');

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // Password must be at least 8 characters long
    if (password.length < 8) return false;

    // Must contain at least one letter
    if (!password.contains(_letterRegex)) return false;

    // Must contain at least one number
    if (!password.contains(_numberRegex)) return false;

    return true;
  }
}
