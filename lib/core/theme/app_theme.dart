import 'package:flutter/material.dart';

/// FinPilot Theme System
/// Crisp Light Mode default with full Dark Mode support
class AppTheme {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF2563EB); // Electric Royal Blue
  static const Color primaryBlueDark = Color(0xFF1D4ED8);
  static const Color primaryBlueLight = Color(0xFF60A5FA);

  static const Color accentEmerald = Color(0xFF10B981); // Emerald / Success
  static const Color accentEmeraldBg = Color(0xFFECFDF5);
  static const Color accentViolet = Color(0xFF7C3AED); // AI Violet
  static const Color accentVioletBg = Color(0xFFF5F3FF);

  static const Color dangerRose = Color(0xFFF43F5E); // Expense / Alert
  static const Color dangerRoseBg = Color(0xFFFFF1F2);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color warningAmberBg = Color(0xFFFEF3C7);

  // Light Mode Palette
  static const Color lightBg = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8FAFC);
  static const Color lightCardBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextMuted = Color(0xFF94A3B8);

  // Dark Mode Palette
  static const Color darkBg = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF131A2A);
  static const Color darkCardBorder = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Border Radii
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Elevation / Shadows
  static List<BoxShadow> softShadow(bool isDark) {
    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.35),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];
    }
    return [
      BoxShadow(
        color: const Color(0xFF0F172A).withOpacity(0.04),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: const Color(0xFF0F172A).withOpacity(0.02),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ];
  }

  // Light Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: primaryBlue,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: accentEmerald,
        tertiary: accentViolet,
        surface: lightSurface,
        background: lightBg,
        error: dangerRose,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lightTextPrimary,
        onBackground: lightTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: lightTextPrimary),
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: lightCardBorder, width: 1),
        ),
      ),
      fontFamily: 'Roboto',
      dividerTheme: const DividerThemeData(
        color: lightCardBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  // Dark Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: accentEmerald,
        tertiary: accentViolet,
        surface: darkSurface,
        background: darkBg,
        error: dangerRose,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkTextPrimary,
        onBackground: darkTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          side: const BorderSide(color: darkCardBorder, width: 1),
        ),
      ),
      fontFamily: 'Roboto',
      dividerTheme: const DividerThemeData(
        color: darkCardBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
