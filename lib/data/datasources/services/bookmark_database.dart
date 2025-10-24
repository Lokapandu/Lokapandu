import 'package:lokapandu/data/mappers/supabase_tourism_spot_mapper.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class BookmarkDatabaseService {
  Future<int> addBookmark(TourismSpot spot);
  Future<void> removeBookmark(int id);
  Future<TourismSpot?> getBookmarkedSpotById(int id);
  Future<List<TourismSpot>> getBookmarkedSpots();
}

class BookmarkDatabaseServiceImpl implements BookmarkDatabaseService {
  static const String _dbName = 'bookmarks.db';
  static const String _tableName = 'bookmarks';
  static const int _version = 1;

  Database? _db;
  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    return await openDatabase(
      _dbName,
      version: _version,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            imageUrl TEXT,
            location TEXT,
            price TEXT,
            rating REAL,
            isFavorite BOOLEAN
          )
        ''');
      },
    );
  }

  @override
  Future<int> addBookmark(TourismSpot spot) async {
    final db = await database;

    final model = spot.toModel();
    final id = await db.insert(
      _tableName,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<void> removeBookmark(int id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<TourismSpot?> getBookmarkedSpotById(int id) async {
    final db = await database;
    final maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TourismSpotModel.fromJson(maps.first).toEntity();
    }
    return null;
  }

  @override
  Future<List<TourismSpot>> getBookmarkedSpots() async {
    final db = await database;
    final maps = await db.query(_tableName);
    return maps.map((e) => TourismSpotModel.fromJson(e).toEntity()).toList();
  }
}
