import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/history_service.dart';
import '../../models/city.dart';
import '../../models/route.dart';

class HistoryState {
  final List<City> recentCities;
  final List<TravelRoute> recentRoutes;

  HistoryState({
    this.recentCities = const [],
    this.recentRoutes = const [],
  });

  HistoryState copyWith({
    List<City>? recentCities,
    List<TravelRoute>? recentRoutes,
  }) {
    return HistoryState(
      recentCities: recentCities ?? this.recentCities,
      recentRoutes: recentRoutes ?? this.recentRoutes,
    );
  }
}

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryService _historyService;

  HistoryNotifier(this._historyService) : super(HistoryState()) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    print('[HistoryNotifier] Loading history...');
    final cities = await _historyService.getRecentCities();
    final routes = await _historyService.getRecentRoutes();
    state = state.copyWith(recentCities: cities, recentRoutes: routes);
    print('[HistoryNotifier] History loaded: ${cities.length} cities, ${routes.length} routes.');
  }

  Future<void> addCity(City city) async {
    if (city.id == null) return;
    print('[HistoryNotifier] Adding city: ${city.name}');
    await _historyService.logCityView(city.id!);
    await loadHistory();
  }

  Future<void> addRoute(TravelRoute route) async {
    print('[HistoryNotifier] Adding route: ${route.name}');
    await _historyService.addRouteToHistory(route);
    await loadHistory();
  }

  Future<void> clearHistory() async {
    print('[HistoryNotifier] Clearing history...');
    await _historyService.clearHistory();
    await loadHistory();
  }
}

final historyServiceProvider = Provider<HistoryService>((ref) {
  return HistoryService();
});

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryState>((ref) {
  final historyService = ref.watch(historyServiceProvider);
  return HistoryNotifier(historyService);
});
