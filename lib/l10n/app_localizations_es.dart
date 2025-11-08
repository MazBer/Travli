// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Travli';

  @override
  String get home => 'Inicio';

  @override
  String get search => 'Buscar';

  @override
  String get settings => 'Ajustes';

  @override
  String get searchForCity => 'Buscar ciudad...';

  @override
  String get searchResults => 'Resultados de búsqueda';

  @override
  String get recentSearches => 'Búsquedas recientes';

  @override
  String get noRecentSearches => 'No hay búsquedas recientes';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get recentTrips => 'Viajes recientes';

  @override
  String get recentlyViewed => 'Vistos recientemente';

  @override
  String get noRecentTrips => 'Aún no hay viajes';

  @override
  String get noRecentlyViewed => 'No hay ciudades vistas recientemente';

  @override
  String get preferences => 'Preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get colorScheme => 'Esquema de color';

  @override
  String get materialYou => 'Material You';

  @override
  String get themeColor => 'Color del tema';

  @override
  String get language => 'Idioma';

  @override
  String get units => 'Unidades';

  @override
  String get metric => 'Métrico';

  @override
  String get imperial => 'Imperial';

  @override
  String get account => 'Cuenta';

  @override
  String get profile => 'Perfil';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get places => 'Lugares';

  @override
  String get selectPlaces => 'Seleccionar lugares para visitar';

  @override
  String get generateRoute => 'Generar ruta';

  @override
  String get optimizedRoute => 'Ruta optimizada';

  @override
  String get saveRoute => 'Guardar ruta';

  @override
  String get shareRoute => 'Compartir ruta';

  @override
  String get noCitiesFound => 'No se encontraron ciudades';

  @override
  String get clearSelection => 'Borrar';

  @override
  String get placesSelected => 'lugares seleccionados';

  @override
  String get generatingRoute => 'Generando ruta optimizada...';

  @override
  String get loadMore => 'Cargar más lugares';

  @override
  String showingPlaces(int count) {
    return 'Mostrando $count lugares';
  }

  @override
  String get routeConfiguration => 'Route Configuration';

  @override
  String get startingLocation => 'Starting Location';

  @override
  String get transportMode => 'Transport Mode';

  @override
  String get configureYourRoute => 'Configure your route preferences';

  @override
  String get firstSelectedPlace => 'First Selected Place';

  @override
  String get startFromFirstPlace =>
      'Start from the first place in your selection';

  @override
  String get currentLocation => 'Current Location';

  @override
  String get useGpsLocation => 'Use your current GPS location';

  @override
  String get customAddress => 'Custom Address';

  @override
  String get enterCustomAddress => 'Enter a specific address or place';

  @override
  String get enterAddress => 'Enter address...';

  @override
  String get gettingLocation => 'Getting location...';

  @override
  String get getMyLocation => 'Get My Location';

  @override
  String get walking => 'Walking';

  @override
  String get driving => 'Driving';

  @override
  String get publicTransport => 'Transit';

  @override
  String get cycling => 'Cycling';

  @override
  String get transitLimitation =>
      'Note: Transit mode shows direct route only (no stops)';

  @override
  String get close => 'Close';

  @override
  String get readMoreWikipedia => 'Read more on Wikipedia';

  @override
  String get noImageAvailable => 'No image available';
}
