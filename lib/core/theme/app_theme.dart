import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  // Light theme colors
  static const Color _lightPrimaryText = Color(0xFF111817);
  static const Color _lightSecondaryText = Color(0xFF618983);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFF0F4F4);
  
  // Dark theme colors
  static const Color _darkPrimaryText = Color(0xFFF0F4F4);
  static const Color _darkSecondaryText = Color(0xFF9DB5B0);
  static const Color _darkBackground = Color(0xFF111817);
  static const Color _darkSurface = Color(0xFF1E2624);
  
  /// Build theme from color scheme (for Material You support)
  static ThemeData buildTheme(ColorScheme colorScheme, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      
      // Scaffold
      scaffoldBackgroundColor: colorScheme.background,
      
      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
          letterSpacing: -0.015,
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
          letterSpacing: -0.015,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
          letterSpacing: -0.015,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: colorScheme.onBackground,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: colorScheme.onBackground,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onBackground,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: colorScheme.secondary,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.secondary,
          letterSpacing: 0.015,
        ),
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.primaryContainer.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: colorScheme.secondary,
          fontSize: 16,
        ),
        prefixIconColor: colorScheme.secondary,
        suffixIconColor: colorScheme.secondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.background,
        selectedItemColor: colorScheme.onBackground,
        unselectedItemColor: colorScheme.secondary,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
      ),
    );
  }
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color scheme
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryText,
        secondary: _lightSecondaryText,
        surface: _lightSurface,
        background: _lightBackground,
        error: AppColors.error,
        onPrimary: _lightBackground,
        onSecondary: _lightBackground,
        onSurface: _lightPrimaryText,
        onBackground: _lightPrimaryText,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: _lightBackground,
      
      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: _lightPrimaryText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _lightPrimaryText,
          letterSpacing: -0.015,
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        // Headings
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: _lightPrimaryText,
          letterSpacing: -0.015,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _lightPrimaryText,
          letterSpacing: -0.015,
        ),
        
        // Body text
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: _lightPrimaryText,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _lightPrimaryText,
        ),
        
        // Labels
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _lightPrimaryText,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _lightSecondaryText,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _lightSecondaryText,
          letterSpacing: 0.015,
        ),
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: _lightSecondaryText,
          fontSize: 16,
        ),
        prefixIconColor: _lightSecondaryText,
        suffixIconColor: _lightSecondaryText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _lightBackground,
        selectedItemColor: _lightPrimaryText,
        unselectedItemColor: _lightSecondaryText,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: _lightBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryText,
        secondary: _darkSecondaryText,
        surface: _darkSurface,
        background: _darkBackground,
        error: AppColors.error,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: _darkBackground,
      
      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: _darkPrimaryText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _darkPrimaryText,
          letterSpacing: -0.015,
        ),
      ),
      
      // Text theme
      textTheme: TextTheme(
        // Headings
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: _darkPrimaryText,
          letterSpacing: -0.015,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _darkPrimaryText,
          letterSpacing: -0.015,
        ),
        
        // Body text
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: _darkPrimaryText,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _darkPrimaryText,
        ),
        
        // Labels
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _darkPrimaryText,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: _darkSecondaryText,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _darkSecondaryText,
          letterSpacing: 0.015,
        ),
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: _darkSecondaryText,
        ),
        prefixIconColor: _darkSecondaryText,
        suffixIconColor: _darkSecondaryText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      
      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _darkBackground,
        selectedItemColor: _darkPrimaryText,
        unselectedItemColor: _darkSecondaryText,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.015,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: _darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
