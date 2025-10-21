import 'package:flutter/material.dart';

/// Color seed options for theme generation
enum ColorSeed {
  travliTeal('Travli Teal', Color(0xFF618983)),
  baselinePurple('M3 Baseline', Color(0xFF6750A4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

/// Color selection method
enum ColorSelectionMethod {
  colorSeed,
  materialYou,
}

/// Screen width breakpoints for responsive design
const double narrowScreenWidthThreshold = 600;
const double mediumWidthBreakpoint = 840;
const double largeWidthBreakpoint = 1200;

/// Animation durations
const Duration shortAnimationDuration = Duration(milliseconds: 200);
const Duration mediumAnimationDuration = Duration(milliseconds: 300);
const Duration longAnimationDuration = Duration(milliseconds: 500);
