import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/main_navigation.dart';
import 'core/providers/theme_provider.dart';
import 'core/services/data_init_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database with mock data
  final dataInitService = DataInitService();
  await dataInitService.initializeMockData();
  
  runApp(
    const ProviderScope(
      child: TravliApp(),
    ),
  );
}

class TravliApp extends ConsumerWidget {
  const TravliApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final useDynamicColor = ref.watch(useDynamicColorProvider);
    
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ThemeData lightTheme;
        ThemeData darkTheme;

        if (useDynamicColor && lightDynamic != null && darkDynamic != null) {
          // Use dynamic colors from wallpaper - rebuild entire theme
          lightTheme = AppTheme.buildTheme(lightDynamic.harmonized(), Brightness.light);
          darkTheme = AppTheme.buildTheme(darkDynamic.harmonized(), Brightness.dark);
        } else {
          // Use default app themes
          lightTheme = AppTheme.lightTheme;
          darkTheme = AppTheme.darkTheme;
        }

        return MaterialApp(
          title: 'Travli',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const MainNavigation(),
        );
      },
    );
  }
}
