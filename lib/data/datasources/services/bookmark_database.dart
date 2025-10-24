import 'dart:convert';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_image_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as dev;

abstract class BookmarkDatabaseService {
  Future<int> addBookmark(TourismSpot spot);
  Future<void> removeBookmark(int id);
  Future<TourismSpot?> getBookmarkedSpotById(int id);
  Future<List<TourismSpot>> getBookmarkedSpots();
}

class BookmarkDatabaseServiceImpl implements BookmarkDatabaseService {
  static const String _dbName = 'bookmarks.db';
  static const String _tableName = 'bookmarks';
  static const int _version = 2;

  Database? _db;
  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    return await openDatabase(
      _dbName,
      version: _version,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            category TEXT NOT NULL,
            city TEXT NOT NULL,
            province TEXT NOT NULL,
            address TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            openTime TEXT NOT NULL,
            closeTime TEXT NOT NULL,
            mapsLink TEXT NOT NULL,
            images TEXT NOT NULL,
            facilities TEXT NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Drop the old table and recreate with new schema
          await db.execute('DROP TABLE IF EXISTS $_tableName');
          await db.execute('''
            CREATE TABLE $_tableName (
              id INTEGER PRIMARY KEY,
              name TEXT NOT NULL,
              description TEXT NOT NULL,
              category TEXT NOT NULL,
              city TEXT NOT NULL,
              province TEXT NOT NULL,
              address TEXT NOT NULL,
              latitude REAL NOT NULL,
              longitude REAL NOT NULL,
              openTime TEXT NOT NULL,
              closeTime TEXT NOT NULL,
              mapsLink TEXT NOT NULL,
              images TEXT NOT NULL,
              facilities TEXT NOT NULL,
              createdAt TEXT NOT NULL
            )
          ''');
        }
      },
    );
  }

  @override
  Future<int> addBookmark(TourismSpot spot) async {
    try {
      final db = await database;

      final data = {
        'id': spot.id,
        'name': spot.name,
        'description': spot.description,
        'category': spot.category,
        'city': spot.city,
        'province': spot.province,
        'address': spot.address,
        'latitude': spot.latitude,
        'longitude': spot.longitude,
        'openTime': spot.openTime,
        'closeTime': spot.closeTime,
        'mapsLink': spot.mapsLink,
        'images': jsonEncode(
          spot.images
              .map(
                (img) => {
                  'id': img.id,
                  'tourismSpotId': img.tourismSpotId,
                  'label': img.label,
                  'imageUrl': img.imageUrl,
                  'createdAt': img.createdAt.toIso8601String(),
                },
              )
              .toList(),
        ),
        'facilities': spot.facilities,
        'createdAt': spot.createdAt.toIso8601String(),
      };

      final id = await db.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e, st) {
      dev.log('Error adding bookmark: $e', stackTrace: st);
      throw DatabaseFailure('Error adding bookmark: $e');
    }
  }

  @override
  Future<void> removeBookmark(int id) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e, st) {
      dev.log('Error removing bookmark: $e', stackTrace: st);
      throw DatabaseFailure('Error removing bookmark: $e');
    }
  }

  @override
  Future<TourismSpot?> getBookmarkedSpotById(int id) async {
    try {
      final db = await database;
      final maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
      if (maps.isNotEmpty) {
        return _mapToTourismSpot(maps.first);
      }
      return null;
    } catch (e, st) {
      dev.log('Error getting bookmarked spot by id: $e', stackTrace: st);
      throw DatabaseFailure('Error getting bookmarked spot by id: $e');
    }
  }

  @override
  Future<List<TourismSpot>> getBookmarkedSpots() async {
    try {
      final db = await database;
      final maps = await db.query(_tableName);
      return maps.map((e) => _mapToTourismSpot(e)).toList();
    } catch (e, st) {
      dev.log('Error getting bookmarked spots: $e', stackTrace: st);
      throw DatabaseFailure('Error getting bookmarked spots: $e');
    }
  }

  TourismSpot _mapToTourismSpot(Map<String, dynamic> map) {
    final imagesJson = map['images'] as String;
    final imagesList = jsonDecode(imagesJson) as List<dynamic>;
    final images = imagesList
        .map(
          (imgMap) => TourismImage(
            id: imgMap['id'] as int,
            tourismSpotId: imgMap['tourismSpotId'] as int,
            label: imgMap['label'] as String,
            imageUrl: imgMap['imageUrl'] as String,
            createdAt: DateTime.parse(imgMap['createdAt'] as String),
          ),
        )
        .toList();

    return TourismSpot(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      city: map['city'] as String,
      province: map['province'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      openTime: map['openTime'] as String,
      closeTime: map['closeTime'] as String,
      mapsLink: map['mapsLink'] as String,
      images: images,
      facilities: map['facilities'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
