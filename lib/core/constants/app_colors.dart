import 'package:flutter/material.dart';

/// App color palette based on design samples
class AppColors {
  // Primary colors
  static const Color primaryText = Color(0xFF111817);
  static const Color secondaryText = Color(0xFF618983);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF0F4F4);
  static const Color border = Color(0xFFF0F4F4);
  
  // Semantic colors
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Opacity variants
  static Color primaryTextLight = primaryText.withOpacity(0.7);
  static Color secondaryTextLight = secondaryText.withOpacity(0.7);
}
