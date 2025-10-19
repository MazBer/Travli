import 'package:shared_preferences/shared_preferences.dart';

class TranslationService {
  static const String _languageKey = 'app_language';
  
  // Supported languages
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'tr': 'Türkçe',
    'de': 'Deutsch',
    'es': 'Español',
    'fr': 'Français',
  };

  /// Get current language
  Future<String> getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  /// Set language
  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  /// Country name translations
  static const Map<String, Map<String, String>> countryTranslations = {
    // Germany
    'Germany': {'en': 'Germany', 'tr': 'Almanya', 'de': 'Deutschland', 'es': 'Alemania', 'fr': 'Allemagne'},
    'Deutschland': {'en': 'Germany', 'tr': 'Almanya', 'de': 'Deutschland', 'es': 'Alemania', 'fr': 'Allemagne'},
    'Almanya': {'en': 'Germany', 'tr': 'Almanya', 'de': 'Deutschland', 'es': 'Alemania', 'fr': 'Allemagne'},
    
    // Turkey
    'Turkey': {'en': 'Turkey', 'tr': 'Türkiye', 'de': 'Türkei', 'es': 'Turquía', 'fr': 'Turquie'},
    'Türkiye': {'en': 'Turkey', 'tr': 'Türkiye', 'de': 'Türkei', 'es': 'Turquía', 'fr': 'Turquie'},
    
    // Spain
    'Spain': {'en': 'Spain', 'tr': 'İspanya', 'de': 'Spanien', 'es': 'España', 'fr': 'Espagne'},
    'España': {'en': 'Spain', 'tr': 'İspanya', 'de': 'Spanien', 'es': 'España', 'fr': 'Espagne'},
    
    // France
    'France': {'en': 'France', 'tr': 'Fransa', 'de': 'Frankreich', 'es': 'Francia', 'fr': 'France'},
    'Fransa': {'en': 'France', 'tr': 'Fransa', 'de': 'Frankreich', 'es': 'Francia', 'fr': 'France'},
    
    // Italy
    'Italy': {'en': 'Italy', 'tr': 'İtalya', 'de': 'Italien', 'es': 'Italia', 'fr': 'Italie'},
    'Italia': {'en': 'Italy', 'tr': 'İtalya', 'de': 'Italien', 'es': 'Italia', 'fr': 'Italie'},
    
    // United Kingdom
    'United Kingdom': {'en': 'United Kingdom', 'tr': 'Birleşik Krallık', 'de': 'Vereinigtes Königreich', 'es': 'Reino Unido', 'fr': 'Royaume-Uni'},
    
    // Netherlands
    'Netherlands': {'en': 'Netherlands', 'tr': 'Hollanda', 'de': 'Niederlande', 'es': 'Países Bajos', 'fr': 'Pays-Bas'},
    'Nederland': {'en': 'Netherlands', 'tr': 'Hollanda', 'de': 'Niederlande', 'es': 'Países Bajos', 'fr': 'Pays-Bas'},
    
    // Greece
    'Greece': {'en': 'Greece', 'tr': 'Yunanistan', 'de': 'Griechenland', 'es': 'Grecia', 'fr': 'Grèce'},
    'Ελλάδα': {'en': 'Greece', 'tr': 'Yunanistan', 'de': 'Griechenland', 'es': 'Grecia', 'fr': 'Grèce'},
    
    // Austria
    'Austria': {'en': 'Austria', 'tr': 'Avusturya', 'de': 'Österreich', 'es': 'Austria', 'fr': 'Autriche'},
    'Österreich': {'en': 'Austria', 'tr': 'Avusturya', 'de': 'Österreich', 'es': 'Austria', 'fr': 'Autriche'},
    
    // Switzerland
    'Switzerland': {'en': 'Switzerland', 'tr': 'İsviçre', 'de': 'Schweiz', 'es': 'Suiza', 'fr': 'Suisse'},
    'Schweiz': {'en': 'Switzerland', 'tr': 'İsviçre', 'de': 'Schweiz', 'es': 'Suiza', 'fr': 'Suisse'},
    
    // Portugal
    'Portugal': {'en': 'Portugal', 'tr': 'Portekiz', 'de': 'Portugal', 'es': 'Portugal', 'fr': 'Portugal'},
    
    // Belgium
    'Belgium': {'en': 'Belgium', 'tr': 'Belçika', 'de': 'Belgien', 'es': 'Bélgica', 'fr': 'Belgique'},
    'België': {'en': 'Belgium', 'tr': 'Belçika', 'de': 'Belgien', 'es': 'Bélgica', 'fr': 'Belgique'},
    
    // Czech Republic
    'Czechia': {'en': 'Czech Republic', 'tr': 'Çekya', 'de': 'Tschechien', 'es': 'República Checa', 'fr': 'République tchèque'},
    'Czech Republic': {'en': 'Czech Republic', 'tr': 'Çekya', 'de': 'Tschechien', 'es': 'República Checa', 'fr': 'République tchèque'},
    
    // Poland
    'Poland': {'en': 'Poland', 'tr': 'Polonya', 'de': 'Polen', 'es': 'Polonia', 'fr': 'Pologne'},
    'Polska': {'en': 'Poland', 'tr': 'Polonya', 'de': 'Polen', 'es': 'Polonia', 'fr': 'Pologne'},
    
    // Hungary
    'Hungary': {'en': 'Hungary', 'tr': 'Macaristan', 'de': 'Ungarn', 'es': 'Hungría', 'fr': 'Hongrie'},
    'Magyarország': {'en': 'Hungary', 'tr': 'Macaristan', 'de': 'Ungarn', 'es': 'Hungría', 'fr': 'Hongrie'},
    
    // United States
    'United States': {'en': 'United States', 'tr': 'Amerika Birleşik Devletleri', 'de': 'Vereinigte Staaten', 'es': 'Estados Unidos', 'fr': 'États-Unis'},
    'United States of America': {'en': 'United States', 'tr': 'Amerika Birleşik Devletleri', 'de': 'Vereinigte Staaten', 'es': 'Estados Unidos', 'fr': 'États-Unis'},
  };

  /// City name translations
  static const Map<String, Map<String, String>> cityTranslations = {
    // Munich
    'Munich': {'en': 'Munich', 'tr': 'Münih', 'de': 'München', 'es': 'Múnich', 'fr': 'Munich'},
    'München': {'en': 'Munich', 'tr': 'Münih', 'de': 'München', 'es': 'Múnich', 'fr': 'Munich'},
    
    // Vienna
    'Vienna': {'en': 'Vienna', 'tr': 'Viyana', 'de': 'Wien', 'es': 'Viena', 'fr': 'Vienne'},
    'Wien': {'en': 'Vienna', 'tr': 'Viyana', 'de': 'Wien', 'es': 'Viena', 'fr': 'Vienne'},
    
    // Prague
    'Prague': {'en': 'Prague', 'tr': 'Prag', 'de': 'Prag', 'es': 'Praga', 'fr': 'Prague'},
    'Praha': {'en': 'Prague', 'tr': 'Prag', 'de': 'Prag', 'es': 'Praga', 'fr': 'Prague'},
    
    // Athens
    'Athens': {'en': 'Athens', 'tr': 'Atina', 'de': 'Athen', 'es': 'Atenas', 'fr': 'Athènes'},
    'Αθήνα': {'en': 'Athens', 'tr': 'Atina', 'de': 'Athen', 'es': 'Atenas', 'fr': 'Athènes'},
    
    // Istanbul
    'Istanbul': {'en': 'Istanbul', 'tr': 'İstanbul', 'de': 'Istanbul', 'es': 'Estambul', 'fr': 'Istanbul'},
    
    // Rome
    'Rome': {'en': 'Rome', 'tr': 'Roma', 'de': 'Rom', 'es': 'Roma', 'fr': 'Rome'},
    'Roma': {'en': 'Rome', 'tr': 'Roma', 'de': 'Rom', 'es': 'Roma', 'fr': 'Rome'},
    
    // Florence
    'Florence': {'en': 'Florence', 'tr': 'Floransa', 'de': 'Florenz', 'es': 'Florencia', 'fr': 'Florence'},
    'Firenze': {'en': 'Florence', 'tr': 'Floransa', 'de': 'Florenz', 'es': 'Florencia', 'fr': 'Florence'},
    
    // Venice
    'Venice': {'en': 'Venice', 'tr': 'Venedik', 'de': 'Venedig', 'es': 'Venecia', 'fr': 'Venise'},
    'Venezia': {'en': 'Venice', 'tr': 'Venedik', 'de': 'Venedig', 'es': 'Venecia', 'fr': 'Venise'},
    
    // Milan
    'Milan': {'en': 'Milan', 'tr': 'Milano', 'de': 'Mailand', 'es': 'Milán', 'fr': 'Milan'},
    'Milano': {'en': 'Milan', 'tr': 'Milano', 'de': 'Mailand', 'es': 'Milán', 'fr': 'Milan'},
    
    // Brussels
    'Brussels': {'en': 'Brussels', 'tr': 'Brüksel', 'de': 'Brüssel', 'es': 'Bruselas', 'fr': 'Bruxelles'},
    'Bruxelles': {'en': 'Brussels', 'tr': 'Brüksel', 'de': 'Brüssel', 'es': 'Bruselas', 'fr': 'Bruxelles'},
    
    // Lisbon
    'Lisbon': {'en': 'Lisbon', 'tr': 'Lizbon', 'de': 'Lissabon', 'es': 'Lisboa', 'fr': 'Lisbonne'},
    'Lisboa': {'en': 'Lisbon', 'tr': 'Lizbon', 'de': 'Lissabon', 'es': 'Lisboa', 'fr': 'Lisbonne'},
    
    // Warsaw
    'Warsaw': {'en': 'Warsaw', 'tr': 'Varşova', 'de': 'Warschau', 'es': 'Varsovia', 'fr': 'Varsovie'},
    'Warszawa': {'en': 'Warsaw', 'tr': 'Varşova', 'de': 'Warschau', 'es': 'Varsovia', 'fr': 'Varsovie'},
    
    // Copenhagen
    'Copenhagen': {'en': 'Copenhagen', 'tr': 'Kopenhag', 'de': 'Kopenhagen', 'es': 'Copenhague', 'fr': 'Copenhague'},
    'København': {'en': 'Copenhagen', 'tr': 'Kopenhag', 'de': 'Kopenhagen', 'es': 'Copenhague', 'fr': 'Copenhague'},
  };

  /// Translate country name
  String translateCountry(String countryName, String targetLanguage) {
    if (countryTranslations.containsKey(countryName)) {
      return countryTranslations[countryName]![targetLanguage] ?? countryName;
    }
    return countryName;
  }

  /// Translate city name
  String translateCity(String cityName, String targetLanguage) {
    if (cityTranslations.containsKey(cityName)) {
      return cityTranslations[cityName]![targetLanguage] ?? cityName;
    }
    return cityName;
  }
}
