import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/city.dart';
import '../../models/place.dart';
import '../services/api_service.dart';

// API Service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// City search query provider
final citySearchQueryProvider = StateProvider<String>((ref) => '');

// City search results provider (from API)
final citySearchResultsProvider = FutureProvider<List<City>>((ref) async {
  final query = ref.watch(citySearchQueryProvider);
  if (query.isEmpty || query.length < 2) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.searchCities(query);
});

// Selected city provider
final selectedCityProvider = StateProvider<City?>((ref) => null);

// Places for selected city provider (from API)
final cityPlacesProvider = FutureProvider<List<Place>>((ref) async {
  final city = ref.watch(selectedCityProvider);
  if (city == null) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  final places = await apiService.getPlacesForCity(city, cityId: city.id);
  
  // Don't enrich here - will load on-demand when detail card opens
  return places;
});
