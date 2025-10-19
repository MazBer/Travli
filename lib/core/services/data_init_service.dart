import '../../repositories/city_repository.dart';
import '../../repositories/place_repository.dart';
import '../utils/mock_data.dart';

class DataInitService {
  final CityRepository _cityRepository = CityRepository();
  final PlaceRepository _placeRepository = PlaceRepository();

  /// Initialize database with mock data
  Future<void> initializeMockData() async {
    // Check if data already exists
    final existingCities = await _cityRepository.getAll();
    if (existingCities.isNotEmpty) {
      print('Database already initialized with ${existingCities.length} cities');
      return;
    }

    print('Initializing database with mock data...');

    // Insert cities
    for (var city in MockData.cities) {
      final createdCity = await _cityRepository.create(city);
      print('Created city: ${createdCity.name}');

      // Insert places for this city
      final places = MockData.getPlacesForCity(createdCity.id!, createdCity.name);
      if (places.isNotEmpty) {
        await _placeRepository.createBatch(places);
        print('  Added ${places.length} places to ${createdCity.name}');
      }
    }

    print('Mock data initialization complete!');
  }

  /// Clear all data and reinitialize
  Future<void> resetData() async {
    print('Resetting database...');
    
    final cities = await _cityRepository.getAll();
    for (var city in cities) {
      await _cityRepository.delete(city.id!);
    }

    await initializeMockData();
  }
}
