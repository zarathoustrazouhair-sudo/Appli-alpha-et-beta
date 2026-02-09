import 'package:flutter/material.dart';

class AppTheme {
  // Dark Prestige Palette
  static const Color scaffoldColor = Color(0xFF121212); // Deep Black
  static const Color surfaceColor = Color(0xFF1E1E1E); // Dark Grey
  static const Color primaryColor = Color(0xFF102A43); // Royal Navy Blue
  static const Color accentColor = Color(0xFFD4AF37); // Gold
  static const Color errorColor = Color(0xFFCF6679);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Color(0xFFE0E0E0),
    ),

    // Card Theme - Corrected Assignment using CardThemeData if available, or just verify if CardTheme is data class.
    // In Flutter 3.10+, CardTheme is data. CardTheme (Widget) is just a theme provider.
    // Wait, ThemeData.cardTheme expects CardTheme. CardTheme extends Diagnosticable (Data).
    // The previous error was: "The argument type 'CardTheme' can't be assigned to the parameter type 'CardThemeData?'".
    // This implies ThemeData field is 'CardThemeData?'. So I MUST use 'CardThemeData'.
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Serif', // Using default serif for now
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: accentColor,
        letterSpacing: 1.2,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Serif',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Serif',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: accentColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFFBDBDBD),
      ), // Grey[400] approx
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: Colors.black, // Text on Gold
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      labelStyle: const TextStyle(color: Color(0xFFBDBDBD)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accentColor),
      ),
    ),
  );
}
