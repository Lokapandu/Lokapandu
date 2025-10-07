// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<UserItineraryModel> _$UserItineraryModelFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return UserItineraryModel(
    id: data['id'] as String,
    userId: data['user_id'] as String,
    itinerariesId: data['itineraries_id'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  );
}

Future<Map<String, dynamic>> _$UserItineraryModelToSupabase(
  UserItineraryModel instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'user_id': instance.userId,
    'itineraries_id': instance.itinerariesId,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

Future<UserItineraryModel> _$UserItineraryModelFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return UserItineraryModel(
    id: data['id'] as String,
    userId: data['user_id'] as String,
    itinerariesId: data['itineraries_id'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$UserItineraryModelToSqlite(
  UserItineraryModel instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'user_id': instance.userId,
    'itineraries_id': instance.itinerariesId,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

/// Construct a [UserItineraryModel]
class UserItineraryModelAdapter
    extends OfflineFirstWithSupabaseAdapter<UserItineraryModel> {
  UserItineraryModelAdapter();

  @override
  final supabaseTableName = 'user_itineraries';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
    'userId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'user_id',
    ),
    'itinerariesId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'itineraries_id',
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
      type: String,
    ),
    'userId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'user_id',
      iterable: false,
      type: String,
    ),
    'itinerariesId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'itineraries_id',
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
    UserItineraryModel instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `UserItineraryModel` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'UserItineraryModel';

  @override
  Future<UserItineraryModel> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$UserItineraryModelFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    UserItineraryModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$UserItineraryModelToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<UserItineraryModel> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$UserItineraryModelFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    UserItineraryModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$UserItineraryModelToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
