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
}
