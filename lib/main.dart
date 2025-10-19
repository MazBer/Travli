import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/main_navigation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TravliApp(),
    ),
  );
}

class TravliApp extends StatelessWidget {
  const TravliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travli',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}
