import 'package:flutter/material.dart';

class AppTheme {
  // Dark Prestige Palette (Gold Master Requirements)
  static const Color scaffoldColor = Color(0xFF121212); // Deep Black
  static const Color surfaceColor = Color(0xFF1E1E1E); // Dark Grey
  static const Color cardColor = Color(0xFF2C2C2C); // Anthracite Grey
  static const Color primaryColor = Color(0xFFD4AF37); // Gold Metallic
  static const Color secondaryColor = Color(0xFFC5A059); // Amandier Gold
  static const Color errorColor = Color(0xFFCF6679);

  // Typography Colors
  static const Color textTitleColor = Color(0xFFFFFFFF); // White
  static const Color textSubtitleColor = Color(0xFFB0B0B0); // Light Grey

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldColor,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      error: errorColor,
      onPrimary: Colors.black, // Text on Gold should be black for contrast
      onSecondary: Colors.black,
      onSurface: textTitleColor,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Radius 16 as requested
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldColor,
      foregroundColor: primaryColor, // Gold icons/text
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Serif',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor, // Gold Title
        letterSpacing: 1.2,
      ),
    ),

    // Text Theme
    textTheme: const TextTheme(
      // Large Titles
      displayLarge: TextStyle(
        fontFamily: 'Serif',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textTitleColor,
      ),
      // Section Headers
      headlineMedium: TextStyle(
        fontFamily: 'Serif',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor, // Gold
      ),
      // Card Titles
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textTitleColor,
      ),
      // Subtitles / Body text
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSubtitleColor,
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Gold
        foregroundColor: Colors.black, // Black Text
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      labelStyle: const TextStyle(color: textSubtitleColor),
      hintStyle: const TextStyle(color: textSubtitleColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
    ),
  );
}
