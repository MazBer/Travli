import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('travli.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Cities table
    await db.execute('''
      CREATE TABLE cities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        country TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        image_url TEXT,
        description TEXT,
        last_viewed TEXT
      )
    ''');

    // Places table
    await db.execute('''
      CREATE TABLE places (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        category TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        image_url TEXT,
        rating REAL,
        address TEXT,
        is_selected INTEGER DEFAULT 0,
        FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE CASCADE
      )
    ''');

    // Routes table
    await db.execute('''
      CREATE TABLE routes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        city_id INTEGER NOT NULL,
        place_ids TEXT NOT NULL,
        total_distance REAL NOT NULL,
        total_duration INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        is_favorite INTEGER DEFAULT 0,
        FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE CASCADE
      )
    ''');

    // Create indexes for better query performance
    await db.execute('CREATE INDEX idx_places_city_id ON places(city_id)');
    await db.execute('CREATE INDEX idx_routes_city_id ON routes(city_id)');
    await db.execute('CREATE INDEX idx_cities_last_viewed ON cities(last_viewed)');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  // Clear all data (useful for testing)
  Future<void> clearAllData() async {
    final db = await instance.database;
    await db.delete('routes');
    await db.delete('places');
    await db.delete('cities');
  }

  // Drop and recreate database (useful for development)
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'travli.db');
    
    await deleteDatabase(path);
    _database = null;
    await database; // Reinitialize
  }
}
