import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/navigation/main_navigation.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/services/data_init_service.dart';
import 'l10n/app_localizations.dart';

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
    final colorSeed = ref.watch(colorSeedProvider);
    final currentLanguage = ref.watch(languageProvider);
    
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Travli',
          debugShowCheckedModeBanner: false,
          
          // Localization
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('tr'),
            Locale('de'),
            Locale('es'),
            Locale('fr'),
          ],
          locale: Locale(currentLanguage),
          
          themeMode: themeMode,
          theme: ThemeData(
            colorSchemeSeed: useDynamicColor && lightDynamic != null
                ? null
                : colorSeed.color,
            colorScheme: useDynamicColor && lightDynamic != null
                ? lightDynamic.harmonized()
                : null,
            useMaterial3: true,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: useDynamicColor && darkDynamic != null
                ? null
                : colorSeed.color,
            colorScheme: useDynamicColor && darkDynamic != null
                ? darkDynamic.harmonized()
                : null,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          home: const MainNavigation(),
        );
      },
    );
  }
}
