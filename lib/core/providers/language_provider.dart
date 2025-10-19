import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/translation_service.dart';

/// Language provider
final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<String> {
  final TranslationService _translationService = TranslationService();

  LanguageNotifier() : super('en') {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final language = await _translationService.getCurrentLanguage();
    state = language;
  }

  Future<void> setLanguage(String languageCode) async {
    await _translationService.setLanguage(languageCode);
    state = languageCode;
  }
}

/// Translation service provider
final translationServiceProvider = Provider<TranslationService>((ref) {
  return TranslationService();
});
