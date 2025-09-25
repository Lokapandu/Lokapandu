// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<TourismSpot> _$TourismSpotFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismSpot(
    id: data['id'] as int,
    name: data['name'] as String,
    description: data['description'] as String,
    city: data['city'] as String,
    province: data['province'] as String,
    category: data['category'] as String,
    address: data['address'] as String,
    latitude: data['latitude'] as double,
    longitude: data['longitude'] as double,
    openTime: data['open_time'] as String,
    closeTime: data['close_time'] as String,
    mapsLink: data['maps_link'] as String,
    facilities: data['facilities'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  );
}

Future<Map<String, dynamic>> _$TourismSpotToSupabase(
  TourismSpot instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'description': instance.description,
    'city': instance.city,
    'province': instance.province,
    'category': instance.category,
    'address': instance.address,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'open_time': instance.openTime,
    'close_time': instance.closeTime,
    'maps_link': instance.mapsLink,
    'facilities': instance.facilities,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

Future<TourismSpot> _$TourismSpotFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismSpot(
    id: data['id'] as int,
    name: data['name'] as String,
    description: data['description'] as String,
    city: data['city'] as String,
    province: data['province'] as String,
    category: data['category'] as String,
    address: data['address'] as String,
    latitude: data['latitude'] as double,
    longitude: data['longitude'] as double,
    openTime: data['open_time'] as String,
    closeTime: data['close_time'] as String,
    mapsLink: data['maps_link'] as String,
    facilities: data['facilities'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$TourismSpotToSqlite(
  TourismSpot instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'description': instance.description,
    'city': instance.city,
    'province': instance.province,
    'category': instance.category,
    'address': instance.address,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'open_time': instance.openTime,
    'close_time': instance.closeTime,
    'maps_link': instance.mapsLink,
    'facilities': instance.facilities,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

/// Construct a [TourismSpot]
class TourismSpotAdapter extends OfflineFirstWithSupabaseAdapter<TourismSpot> {
  TourismSpotAdapter();

  @override
  final supabaseTableName = 'tourism_spots';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
    'name': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'name',
    ),
    'description': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'description',
    ),
    'city': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'city',
    ),
    'province': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'province',
    ),
    'category': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'category',
    ),
    'address': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'address',
    ),
    'latitude': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'latitude',
    ),
    'longitude': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'longitude',
    ),
    'openTime': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'open_time',
    ),
    'closeTime': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'close_time',
    ),
    'mapsLink': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'maps_link',
    ),
    'facilities': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'facilities',
    ),
    'createdAt': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'created_at',
    ),
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: int,
    ),
    'name': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'name',
      iterable: false,
      type: String,
    ),
    'description': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'description',
      iterable: false,
      type: String,
    ),
    'city': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'city',
      iterable: false,
      type: String,
    ),
    'province': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'province',
      iterable: false,
      type: String,
    ),
    'category': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'category',
      iterable: false,
      type: String,
    ),
    'address': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'address',
      iterable: false,
      type: String,
    ),
    'latitude': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'latitude',
      iterable: false,
      type: double,
    ),
    'longitude': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'longitude',
      iterable: false,
      type: double,
    ),
    'openTime': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'open_time',
      iterable: false,
      type: String,
    ),
    'closeTime': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'close_time',
      iterable: false,
      type: String,
    ),
    'mapsLink': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'maps_link',
      iterable: false,
      type: String,
    ),
    'facilities': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'facilities',
      iterable: false,
      type: String,
    ),
    'createdAt': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'created_at',
      iterable: false,
      type: DateTime,
    ),
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
    TourismSpot instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `TourismSpot` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'TourismSpot';

  @override
  Future<TourismSpot> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismSpotFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    TourismSpot input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismSpotToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<TourismSpot> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismSpotFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    TourismSpot input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismSpotToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
