import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/city_repository.dart';
import '../../repositories/place_repository.dart';
import '../../repositories/route_repository.dart';

// Repository providers
final cityRepositoryProvider = Provider<CityRepository>((ref) {
  return CityRepository();
});

final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  return PlaceRepository();
});

final routeRepositoryProvider = Provider<RouteRepository>((ref) {
  return RouteRepository();
});
