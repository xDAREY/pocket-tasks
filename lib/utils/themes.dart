import 'package:flutter/material.dart';

class AppThemes {
  // Color palette matching your design
  static const Color primaryBeige = Color(0xFFF5E6D3);
  static const Color lightBeige = Color(0xFFFAF0E6);
  static const Color darkBrown = Color(0xFF8B4513);
  static const Color mediumBrown = Color(0xFFA0522D);
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textLight = Color(0xFF6B6B6B);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: darkBrown,
        secondary: mediumBrown,
        surface: Colors.white,
        // background: lightBeige,
        outline: primaryBeige,
      ),
      scaffoldBackgroundColor: lightBeige,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBeige,
        foregroundColor: textDark,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: primaryBeige,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        selectedColor: darkBrown,
        labelStyle: const TextStyle(color: textDark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: darkBrown.withValues(alpha: 0.3)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: primaryBeige,
        secondary: lightBeige,
        surface: Color(0xFF1E1E1E),
        // background: Color(0xFF121212),
        outline: Color(0xFF2C2C2C),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF2C2C2C),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        selectedColor: primaryBeige,
        labelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: primaryBeige.withValues(alpha: 0.3)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBeige,
        foregroundColor: Color(0xFF121212),
        shape: CircleBorder(),
      ),
    );
  }
}