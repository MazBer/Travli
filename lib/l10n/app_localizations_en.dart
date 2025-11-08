// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Travli';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get settings => 'Settings';

  @override
  String get searchForCity => 'Search for a city...';

  @override
  String get searchResults => 'Search Results';

  @override
  String get recentSearches => 'Recent Searches';

  @override
  String get noRecentSearches => 'No recent searches';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get recentTrips => 'Recent Trips';

  @override
  String get recentlyViewed => 'Recently Viewed';

  @override
  String get noRecentTrips => 'No recent trips yet';

  @override
  String get noRecentlyViewed => 'No recently viewed cities';

  @override
  String get preferences => 'Preferences';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get colorScheme => 'Color Scheme';

  @override
  String get materialYou => 'Material You';

  @override
  String get themeColor => 'Theme Color';

  @override
  String get language => 'Language';

  @override
  String get units => 'Units';

  @override
  String get metric => 'Metric';

  @override
  String get imperial => 'Imperial';

  @override
  String get account => 'Account';

  @override
  String get profile => 'Profile';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get places => 'Places';

  @override
  String get selectPlaces => 'Select places to visit';

  @override
  String get generateRoute => 'Generate Route';

  @override
  String get optimizedRoute => 'Optimized Route';

  @override
  String get saveRoute => 'Save Route';

  @override
  String get shareRoute => 'Share Route';

  @override
  String get noCitiesFound => 'No cities found';

  @override
  String get clearSelection => 'Clear';

  @override
  String get placesSelected => 'places selected';

  @override
  String get generatingRoute => 'Generating optimized route...';

  @override
  String get loadMore => 'Load More Places';

  @override
  String showingPlaces(int count) {
    return 'Showing $count places';
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
