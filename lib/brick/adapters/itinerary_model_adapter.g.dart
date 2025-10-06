// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<ItineraryModel> _$ItineraryModelFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return ItineraryModel(
    id: data['id'] as int,
    name: data['name'] as String,
    notes: data['notes'] == null ? null : data['notes'] as String?,
    startTime: DateTime.parse(data['start_time'] as String),
    endTime: DateTime.parse(data['end_time'] as String),
    createdAt: DateTime.parse(data['created_at'] as String),
    tourismSpotId: data['tourism_spot_id'] == null
        ? null
        : data['tourism_spot_id'] as int?,
  );
}

Future<Map<String, dynamic>> _$ItineraryModelToSupabase(
  ItineraryModel instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'notes': instance.notes,
    'start_time': instance.startTime.toIso8601String(),
    'end_time': instance.endTime.toIso8601String(),
    'created_at': instance.createdAt.toIso8601String(),
    'tourism_spot_id': instance.tourismSpotId,
  };
}

Future<ItineraryModel> _$ItineraryModelFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return ItineraryModel(
    id: data['id'] as int,
    name: data['name'] as String,
    notes: data['notes'] == null ? null : data['notes'] as String?,
    startTime: DateTime.parse(data['start_time'] as String),
    endTime: DateTime.parse(data['end_time'] as String),
    createdAt: DateTime.parse(data['created_at'] as String),
    tourismSpotId: data['tourism_spot_id'] == null
        ? null
        : data['tourism_spot_id'] as int?,
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$ItineraryModelToSqlite(
  ItineraryModel instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'name': instance.name,
    'notes': instance.notes,
    'start_time': instance.startTime.toIso8601String(),
    'end_time': instance.endTime.toIso8601String(),
    'created_at': instance.createdAt.toIso8601String(),
    'tourism_spot_id': instance.tourismSpotId,
  };
}

/// Construct a [ItineraryModel]
class ItineraryModelAdapter
    extends OfflineFirstWithSupabaseAdapter<ItineraryModel> {
  ItineraryModelAdapter();

  @override
  final supabaseTableName = 'itineraries';
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
    'notes': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'notes',
    ),
    'startTime': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'start_time',
    ),
    'endTime': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'end_time',
    ),
    'createdAt': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'created_at',
    ),
    'tourismSpotId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'tourism_spot_id',
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
    'notes': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'notes',
      iterable: false,
      type: String,
    ),
    'startTime': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'start_time',
      iterable: false,
      type: DateTime,
    ),
    'endTime': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'end_time',
      iterable: false,
      type: DateTime,
    ),
    'createdAt': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'created_at',
      iterable: false,
      type: DateTime,
    ),
    'tourismSpotId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'tourism_spot_id',
      iterable: false,
      type: int,
    ),
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
    ItineraryModel instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `ItineraryModel` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'ItineraryModel';

  @override
  Future<ItineraryModel> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ItineraryModelFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    ItineraryModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ItineraryModelToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<ItineraryModel> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ItineraryModelFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    ItineraryModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ItineraryModelToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
