import 'package:sqflite/sqflite.dart';
import '../core/services/database_service.dart';
import '../models/city.dart';

class CityRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  // Create a new city
  Future<City> create(City city) async {
    final db = await _dbService.database;
    final id = await db.insert('cities', city.toMap());
    return city.copyWith(id: id);
  }

  // Get city by ID
  Future<City?> getById(int id) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'cities',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return City.fromMap(maps.first);
  }

  // Get all cities
  Future<List<City>> getAll() async {
    final db = await _dbService.database;
    final maps = await db.query('cities', orderBy: 'name ASC');
    return maps.map((map) => City.fromMap(map)).toList();
  }

  // Search cities by name
  Future<List<City>> searchByName(String query) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'cities',
      where: 'name LIKE ? OR country LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'name ASC',
    );
    return maps.map((map) => City.fromMap(map)).toList();
  }

  // Get recently viewed cities
  Future<List<City>> getRecentlyViewed({int limit = 10}) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'cities',
      where: 'last_viewed IS NOT NULL',
      orderBy: 'last_viewed DESC',
      limit: limit,
    );
    return maps.map((map) => City.fromMap(map)).toList();
  }

  // Update city
  Future<int> update(City city) async {
    final db = await _dbService.database;
    return await db.update(
      'cities',
      city.toMap(),
      where: 'id = ?',
      whereArgs: [city.id],
    );
  }

  // Update last viewed timestamp
  Future<void> updateLastViewed(int cityId) async {
    final db = await _dbService.database;
    await db.update(
      'cities',
      {'last_viewed': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [cityId],
    );
  }

  // Delete city
  Future<int> delete(int id) async {
    final db = await _dbService.database;
    return await db.delete(
      'cities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Check if city exists
  Future<bool> exists(String name, String country) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'cities',
      where: 'name = ? AND country = ?',
      whereArgs: [name, country],
    );
    return maps.isNotEmpty;
  }

  // Get or create city
  Future<City> getOrCreate(City city) async {
    final existing = await searchByName(city.name);
    
    for (var existingCity in existing) {
      if (existingCity.name == city.name && existingCity.country == city.country) {
        return existingCity;
      }
    }
    
    return await create(city);
  }
}
