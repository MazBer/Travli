import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme mode notifier
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  static const String _themeModeKey = 'theme_mode';

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);
    
    if (themeModeString != null) {
      state = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }
}

// Provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

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
