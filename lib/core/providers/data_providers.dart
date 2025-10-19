import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/city.dart';
import '../../models/place.dart';
import '../../models/route.dart';
import 'repository_providers.dart';

// Cities providers
final citiesProvider = FutureProvider<List<City>>((ref) async {
  final repository = ref.watch(cityRepositoryProvider);
  return await repository.getAll();
});

final recentCitiesProvider = FutureProvider<List<City>>((ref) async {
  final repository = ref.watch(cityRepositoryProvider);
  return await repository.getRecentlyViewed(limit: 5);
});

// Search provider
final citySearchProvider = StateProvider<String>((ref) => '');

final citySearchResultsProvider = FutureProvider<List<City>>((ref) async {
  final query = ref.watch(citySearchProvider);
  if (query.isEmpty) return [];
  
  final repository = ref.watch(cityRepositoryProvider);
  return await repository.searchByName(query);
});

// Selected city provider
final selectedCityProvider = StateProvider<City?>((ref) => null);

// Places providers
final placesProvider = FutureProvider.family<List<Place>, int>((ref, cityId) async {
  final repository = ref.watch(placeRepositoryProvider);
  return await repository.getByCity(cityId);
});

final selectedPlacesProvider = FutureProvider.family<List<Place>, int>((ref, cityId) async {
  final repository = ref.watch(placeRepositoryProvider);
  return await repository.getSelected(cityId);
});

// Routes providers
final routesProvider = FutureProvider<List<TravelRoute>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  return await repository.getAll();
});

final recentRoutesProvider = FutureProvider<List<TravelRoute>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  return await repository.getRecent(limit: 5);
});

final favoriteRoutesProvider = FutureProvider<List<TravelRoute>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  return await repository.getFavorites();
});

// Selected route provider
final selectedRouteProvider = StateProvider<TravelRoute?>((ref) => null);
