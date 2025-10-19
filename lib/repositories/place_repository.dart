import 'package:sqflite/sqflite.dart';
import '../core/services/database_service.dart';
import '../models/place.dart';

class PlaceRepository {
  final DatabaseService _dbService = DatabaseService.instance;

  // Create a new place
  Future<Place> create(Place place) async {
    final db = await _dbService.database;
    final id = await db.insert('places', place.toMap());
    return place.copyWith(id: id);
  }

  // Create multiple places
  Future<List<Place>> createBatch(List<Place> places) async {
    final db = await _dbService.database;
    final batch = db.batch();
    
    for (var place in places) {
      batch.insert('places', place.toMap());
    }
    
    await batch.commit();
    return places;
  }

  // Get place by ID
  Future<Place?> getById(int id) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'places',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Place.fromMap(maps.first);
  }

  // Get all places for a city
  Future<List<Place>> getByCity(int cityId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'places',
      where: 'city_id = ?',
      whereArgs: [cityId],
      orderBy: 'name ASC',
    );
    return maps.map((map) => Place.fromMap(map)).toList();
  }

  // Get places by category
  Future<List<Place>> getByCategory(int cityId, String category) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'places',
      where: 'city_id = ? AND category = ?',
      whereArgs: [cityId, category],
      orderBy: 'name ASC',
    );
    return maps.map((map) => Place.fromMap(map)).toList();
  }

  // Get selected places for a city
  Future<List<Place>> getSelected(int cityId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'places',
      where: 'city_id = ? AND is_selected = 1',
      whereArgs: [cityId],
    );
    return maps.map((map) => Place.fromMap(map)).toList();
  }

  // Search places by name
  Future<List<Place>> searchByName(int cityId, String query) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'places',
      where: 'city_id = ? AND (name LIKE ? OR description LIKE ?)',
      whereArgs: [cityId, '%$query%', '%$query%'],
      orderBy: 'name ASC',
    );
    return maps.map((map) => Place.fromMap(map)).toList();
  }

  // Update place
  Future<int> update(Place place) async {
    final db = await _dbService.database;
    return await db.update(
      'places',
      place.toMap(),
      where: 'id = ?',
      whereArgs: [place.id],
    );
  }

  // Toggle place selection
  Future<void> toggleSelection(int placeId) async {
    final place = await getById(placeId);
    if (place != null) {
      await update(place.copyWith(isSelected: !place.isSelected));
    }
  }

  // Clear all selections for a city
  Future<void> clearSelections(int cityId) async {
    final db = await _dbService.database;
    await db.update(
      'places',
      {'is_selected': 0},
      where: 'city_id = ?',
      whereArgs: [cityId],
    );
  }

  // Delete place
  Future<int> delete(int id) async {
    final db = await _dbService.database;
    return await db.delete(
      'places',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all places for a city
  Future<int> deleteByCity(int cityId) async {
    final db = await _dbService.database;
    return await db.delete(
      'places',
      where: 'city_id = ?',
      whereArgs: [cityId],
    );
  }

  // Get places by IDs (for route display)
  Future<List<Place>> getByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    
    final db = await _dbService.database;
    final placeholders = List.filled(ids.length, '?').join(',');
    final maps = await db.query(
      'places',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    
    // Maintain the order of IDs
    final placeMap = {for (var map in maps) map['id'] as int: Place.fromMap(map)};
    return ids.map((id) => placeMap[id]!).toList();
  }
}
