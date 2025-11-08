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
  
  // Lightweight enrichment: Fetch only primary image for first 20 places (for thumbnails)
  // Full data (description, multiple images) loads on-demand when detail card opens
  print('Fetching thumbnails for first 20 places...');
  final enrichedPlaces = <Place>[];
  
  for (int i = 0; i < places.length; i++) {
    if (i < 20) {
      // Fetch only thumbnail (lightweight)
      final enriched = await apiService.enrichPlaceWithWikipedia(
        places[i],
        thumbnailOnly: true,
      );
      enrichedPlaces.add(enriched);
    } else {
      // Keep rest as-is
      enrichedPlaces.add(places[i]);
    }
  }
  
  print('Thumbnails loaded: ${enrichedPlaces.where((p) => p.primaryImageUrl != null).length} places have images');
  return enrichedPlaces;
});
