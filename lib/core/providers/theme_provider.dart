import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/theme_constants.dart';

/// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'system';
    state = _themeModeFromString(themeModeString);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeModeToString(mode));
    state = mode;
  }

  ThemeMode _themeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

/// Color seed provider
final colorSeedProvider = StateNotifierProvider<ColorSeedNotifier, ColorSeed>((ref) {
  return ColorSeedNotifier();
});

class ColorSeedNotifier extends StateNotifier<ColorSeed> {
  ColorSeedNotifier() : super(ColorSeed.travliTeal) {
    _loadColorSeed();
  }

  Future<void> _loadColorSeed() async {
    final prefs = await SharedPreferences.getInstance();
    final colorIndex = prefs.getInt('colorSeed') ?? 0;
    if (colorIndex >= 0 && colorIndex < ColorSeed.values.length) {
      state = ColorSeed.values[colorIndex];
    }
  }

  Future<void> setColorSeed(ColorSeed seed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorSeed', seed.index);
    state = seed;
  }
}

// Color scheme preference notifier
class ColorSchemeNotifier extends StateNotifier<bool> {
  ColorSchemeNotifier() : super(false) {
    _loadColorScheme();
  }

  static const String _colorSchemeKey = 'use_dynamic_color';

  Future<void> _loadColorScheme() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_colorSchemeKey) ?? false;
  }

  Future<void> setUseDynamicColor(bool useDynamic) async {
    state = useDynamic;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_colorSchemeKey, useDynamic);
  }
}

// Provider for dynamic color preference
final useDynamicColorProvider = StateNotifierProvider<ColorSchemeNotifier, bool>(
  (ref) => ColorSchemeNotifier(),
);
