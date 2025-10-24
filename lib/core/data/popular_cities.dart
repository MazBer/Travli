import '../../models/city.dart';

/// Popular tourist cities as offline fallback
/// Used when API search fails or returns no results
class PopularCities {
  static final List<City> cities = [
    // Europe - Major Tourist Destinations
    City(
      id: 1,
      name: 'Rome',
      country: 'Italy',
      latitude: 41.9028,
      longitude: 12.4964,
      description: 'The Eternal City',
    ),
    City(
      id: 2,
      name: 'Paris',
      country: 'France',
      latitude: 48.8566,
      longitude: 2.3522,
      description: 'The City of Light',
    ),
    City(
      id: 3,
      name: 'London',
      country: 'United Kingdom',
      latitude: 51.5074,
      longitude: -0.1278,
      description: 'The Capital of England',
    ),
    City(
      id: 4,
      name: 'Barcelona',
      country: 'Spain',
      latitude: 41.3851,
      longitude: 2.1734,
      description: 'Gaudí\'s Masterpiece City',
    ),
    City(
      id: 5,
      name: 'Istanbul',
      country: 'Turkey',
      latitude: 41.0082,
      longitude: 28.9784,
      description: 'Where East Meets West',
    ),
    City(
      id: 6,
      name: 'Amsterdam',
      country: 'Netherlands',
      latitude: 52.3676,
      longitude: 4.9041,
      description: 'The Venice of the North',
    ),
    City(
      id: 7,
      name: 'Berlin',
      country: 'Germany',
      latitude: 52.5200,
      longitude: 13.4050,
      description: 'The Capital of Germany',
    ),
    City(
      id: 8,
      name: 'Vienna',
      country: 'Austria',
      latitude: 48.2082,
      longitude: 16.3738,
      description: 'The City of Music',
    ),
    City(
      id: 9,
      name: 'Prague',
      country: 'Czech Republic',
      latitude: 50.0755,
      longitude: 14.4378,
      description: 'The City of a Hundred Spires',
    ),
    City(
      id: 10,
      name: 'Athens',
      country: 'Greece',
      latitude: 37.9838,
      longitude: 23.7275,
      description: 'The Cradle of Western Civilization',
    ),
    City(
      id: 11,
      name: 'Madrid',
      country: 'Spain',
      latitude: 40.4168,
      longitude: -3.7038,
      description: 'The Capital of Spain',
    ),
    City(
      id: 12,
      name: 'Lisbon',
      country: 'Portugal',
      latitude: 38.7223,
      longitude: -9.1393,
      description: 'The City of Seven Hills',
    ),
    City(
      id: 13,
      name: 'Budapest',
      country: 'Hungary',
      latitude: 47.4979,
      longitude: 19.0402,
      description: 'The Pearl of the Danube',
    ),
    City(
      id: 14,
      name: 'Venice',
      country: 'Italy',
      latitude: 45.4408,
      longitude: 12.3155,
      description: 'The Floating City',
    ),
    City(
      id: 15,
      name: 'Florence',
      country: 'Italy',
      latitude: 43.7696,
      longitude: 11.2558,
      description: 'The Birthplace of Renaissance',
    ),
    
    // Asia
    City(
      id: 16,
      name: 'Tokyo',
      country: 'Japan',
      latitude: 35.6762,
      longitude: 139.6503,
      description: 'The Capital of Japan',
    ),
    City(
      id: 17,
      name: 'Dubai',
      country: 'United Arab Emirates',
      latitude: 25.2048,
      longitude: 55.2708,
      description: 'The City of Gold',
    ),
    City(
      id: 18,
      name: 'Bangkok',
      country: 'Thailand',
      latitude: 13.7563,
      longitude: 100.5018,
      description: 'The City of Angels',
    ),
    City(
      id: 19,
      name: 'Singapore',
      country: 'Singapore',
      latitude: 1.3521,
      longitude: 103.8198,
      description: 'The Lion City',
    ),
    City(
      id: 20,
      name: 'Hong Kong',
      country: 'China',
      latitude: 22.3193,
      longitude: 114.1694,
      description: 'The Pearl of the Orient',
    ),
    
    // Americas
    City(
      id: 21,
      name: 'New York',
      country: 'United States',
      latitude: 40.7128,
      longitude: -74.0060,
      description: 'The Big Apple',
    ),
    City(
      id: 22,
      name: 'Los Angeles',
      country: 'United States',
      latitude: 34.0522,
      longitude: -118.2437,
      description: 'The City of Angels',
    ),
    City(
      id: 23,
      name: 'San Francisco',
      country: 'United States',
      latitude: 37.7749,
      longitude: -122.4194,
      description: 'The Golden Gate City',
    ),
    City(
      id: 24,
      name: 'Rio de Janeiro',
      country: 'Brazil',
      latitude: -22.9068,
      longitude: -43.1729,
      description: 'The Marvelous City',
    ),
    City(
      id: 25,
      name: 'Buenos Aires',
      country: 'Argentina',
      latitude: -34.6037,
      longitude: -58.3816,
      description: 'The Paris of South America',
    ),
    
    // Middle East & Africa
    City(
      id: 26,
      name: 'Cairo',
      country: 'Egypt',
      latitude: 30.0444,
      longitude: 31.2357,
      description: 'The City of a Thousand Minarets',
    ),
    City(
      id: 27,
      name: 'Jerusalem',
      country: 'Israel',
      latitude: 31.7683,
      longitude: 35.2137,
      description: 'The Holy City',
    ),
    City(
      id: 28,
      name: 'Marrakech',
      country: 'Morocco',
      latitude: 31.6295,
      longitude: -7.9811,
      description: 'The Red City',
    ),
    
    // Oceania
    City(
      id: 29,
      name: 'Sydney',
      country: 'Australia',
      latitude: -33.8688,
      longitude: 151.2093,
      description: 'The Harbour City',
    ),
    City(
      id: 30,
      name: 'Melbourne',
      country: 'Australia',
      latitude: -37.8136,
      longitude: 144.9631,
      description: 'The Cultural Capital',
    ),
  ];

  /// Search cities by query (case-insensitive)
  static List<City> search(String query) {
    if (query.isEmpty) return cities;
    
    final lowerQuery = query.toLowerCase();
    return cities.where((city) {
      return city.name.toLowerCase().contains(lowerQuery) ||
             city.country.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get city by name (exact match)
  static City? getByName(String name) {
    try {
      return cities.firstWhere(
        (city) => city.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
