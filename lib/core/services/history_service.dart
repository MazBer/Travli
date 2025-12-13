import 'package:sqflite/sqflite.dart';
import '../../models/city.dart';
import '../../models/route.dart';
import 'database_service.dart';

class HistoryService {
  final DatabaseService _dbService = DatabaseService.instance;

  /// Updates the last_viewed timestamp for a given city.
  Future<void> logCityView(int cityId) async {
    final db = await _dbService.database;
    await db.update(
      'cities',
      {'last_viewed': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [cityId],
    );
  }

  /// Fetches the most recently viewed cities.
  Future<List<City>> getRecentCities({int limit = 5}) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'cities',
      where: 'last_viewed IS NOT NULL',
      orderBy: 'last_viewed DESC',
      limit: limit,
    );

    if (maps.isEmpty) {
      return [];
    }

    return maps.map((json) => City.fromMap(json)).toList();
  }

  /// Adds a new route to the history.
  Future<void> addRouteToHistory(TravelRoute route) async {
    final db = await _dbService.database;
    await db.insert('routes', route.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Fetches the most recently created routes.
  Future<List<TravelRoute>> getRecentRoutes({int limit = 5}) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      orderBy: 'created_at DESC',
      limit: limit,
    );

    if (maps.isEmpty) {
      return [];
    }

    return maps.map((json) => TravelRoute.fromMap(json)).toList();
  }

  /// Clears all history data.
  Future<void> clearHistory() async {
    final db = await _dbService.database;
    // Clear city view history by setting last_viewed to null
    await db.update('cities', {'last_viewed': null});
    // Delete all saved routes
    await db.delete('routes');
  }
}
