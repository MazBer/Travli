import 'package:sqflite/sqflite.dart';
import '../core/services/database_service.dart';
import '../models/route.dart';

class RouteRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  // Create a new route
  Future<TravelRoute> create(TravelRoute route) async {
    final db = await _dbService.database;
    final id = await db.insert('routes', route.toMap());
    return route.copyWith(id: id);
  }

  // Get route by ID
  Future<TravelRoute?> getById(int id) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return TravelRoute.fromMap(maps.first);
  }

  // Get all routes
  Future<List<TravelRoute>> getAll() async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => TravelRoute.fromMap(map)).toList();
  }

  // Get routes for a city
  Future<List<TravelRoute>> getByCity(int cityId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      where: 'city_id = ?',
      whereArgs: [cityId],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => TravelRoute.fromMap(map)).toList();
  }

  // Get favorite routes
  Future<List<TravelRoute>> getFavorites() async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      where: 'is_favorite = 1',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => TravelRoute.fromMap(map)).toList();
  }

  // Get recent routes
  Future<List<TravelRoute>> getRecent({int limit = 10}) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      orderBy: 'created_at DESC',
      limit: limit,
    );
    return maps.map((map) => TravelRoute.fromMap(map)).toList();
  }

  // Update route
  Future<int> update(TravelRoute route) async {
    final db = await _dbService.database;
    return await db.update(
      'routes',
      route.toMap(),
      where: 'id = ?',
      whereArgs: [route.id],
    );
  }

  // Toggle favorite status
  Future<void> toggleFavorite(int routeId) async {
    final route = await getById(routeId);
    if (route != null) {
      await update(route.copyWith(isFavorite: !route.isFavorite));
    }
  }

  // Delete route
  Future<int> delete(int id) async {
    final db = await _dbService.database;
    return await db.delete(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all routes for a city
  Future<int> deleteByCity(int cityId) async {
    final db = await _dbService.database;
    return await db.delete(
      'routes',
      where: 'city_id = ?',
      whereArgs: [cityId],
    );
  }

  // Search routes by name
  Future<List<TravelRoute>> searchByName(String query) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'routes',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => TravelRoute.fromMap(map)).toList();
  }
}
