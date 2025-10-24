/// City name translations for major tourist destinations
/// Format: {englishName: {languageCode: translatedName}}
class CityTranslations {
  static const Map<String, Map<String, String>> translations = {
    'Rome': {
      'tr': 'Roma',
      'de': 'Rom',
      'es': 'Roma',
      'fr': 'Rome',
      'it': 'Roma',
    },
    'Paris': {
      'tr': 'Paris',
      'de': 'Paris',
      'es': 'París',
      'fr': 'Paris',
      'it': 'Parigi',
    },
    'London': {
      'tr': 'Londra',
      'de': 'London',
      'es': 'Londres',
      'fr': 'Londres',
      'it': 'Londra',
    },
    'Athens': {
      'tr': 'Atina',
      'de': 'Athen',
      'es': 'Atenas',
      'fr': 'Athènes',
      'it': 'Atene',
    },
    'Vienna': {
      'tr': 'Viyana',
      'de': 'Wien',
      'es': 'Viena',
      'fr': 'Vienne',
      'it': 'Vienna',
    },
    'Prague': {
      'tr': 'Prag',
      'de': 'Prag',
      'es': 'Praga',
      'fr': 'Prague',
      'it': 'Praga',
    },
    'Venice': {
      'tr': 'Venedik',
      'de': 'Venedig',
      'es': 'Venecia',
      'fr': 'Venise',
      'it': 'Venezia',
    },
    'Florence': {
      'tr': 'Floransa',
      'de': 'Florenz',
      'es': 'Florencia',
      'fr': 'Florence',
      'it': 'Firenze',
    },
    'Munich': {
      'tr': 'Münih',
      'de': 'München',
      'es': 'Múnich',
      'fr': 'Munich',
      'it': 'Monaco',
    },
    'Moscow': {
      'tr': 'Moskova',
      'de': 'Moskau',
      'es': 'Moscú',
      'fr': 'Moscou',
      'it': 'Mosca',
    },
    'Istanbul': {
      'tr': 'İstanbul',
      'de': 'Istanbul',
      'es': 'Estambul',
      'fr': 'Istanbul',
      'it': 'Istanbul',
    },
    'Cairo': {
      'tr': 'Kahire',
      'de': 'Kairo',
      'es': 'El Cairo',
      'fr': 'Le Caire',
      'it': 'Il Cairo',
    },
    'Jerusalem': {
      'tr': 'Kudüs',
      'de': 'Jerusalem',
      'es': 'Jerusalén',
      'fr': 'Jérusalem',
      'it': 'Gerusalemme',
    },
    'New York': {
      'tr': 'New York',
      'de': 'New York',
      'es': 'Nueva York',
      'fr': 'New York',
      'it': 'New York',
    },
    'Tokyo': {
      'tr': 'Tokyo',
      'de': 'Tokio',
      'es': 'Tokio',
      'fr': 'Tokyo',
      'it': 'Tokyo',
    },
  };

  /// Get translated city name
  /// Returns original name if translation not available
  static String getTranslatedName(String cityName, String languageCode) {
    // If English, return as is
    if (languageCode == 'en') return cityName;
    
    // Try to find translation
    final cityTranslations = translations[cityName];
    if (cityTranslations != null && cityTranslations.containsKey(languageCode)) {
      return cityTranslations[languageCode]!;
    }
    
    // Return original name if no translation
    return cityName;
  }

  /// Get all available languages for a city
  static List<String> getAvailableLanguages(String cityName) {
    final cityTranslations = translations[cityName];
    if (cityTranslations == null) return [];
    return cityTranslations.keys.toList();
  }
}
