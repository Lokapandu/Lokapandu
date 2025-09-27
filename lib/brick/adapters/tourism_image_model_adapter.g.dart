// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<TourismImageModel> _$TourismImageModelFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismImageModel(
    id: data['id'] as int,
    tourismSpot: await TourismSpotModelAdapter().fromSupabase(
      data['tourism_spot'],
      provider: provider,
      repository: repository,
    ),
    label: data['label'] as String,
    imageUrl: data['image_url'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  );
}

Future<Map<String, dynamic>> _$TourismImageModelToSupabase(
  TourismImageModel instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'tourism_spot': await TourismSpotModelAdapter().toSupabase(
      instance.tourismSpot,
      provider: provider,
      repository: repository,
    ),
    'tourism_spot_id': instance.tourismSpotId,
    'label': instance.label,
    'image_url': instance.imageUrl,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

Future<TourismImageModel> _$TourismImageModelFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismImageModel(
    id: data['id'] as int,
    tourismSpot: (await repository!.getAssociation<TourismSpotModel>(
      Query.where(
        'primaryKey',
        data['tourism_spot_TourismSpotModel_brick_id'] as int,
        limit1: true,
      ),
    ))!.first,
    label: data['label'] as String,
    imageUrl: data['image_url'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$TourismImageModelToSqlite(
  TourismImageModel instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'tourism_spot_TourismSpotModel_brick_id':
        instance.tourismSpot.primaryKey ??
        await provider.upsert<TourismSpotModel>(
          instance.tourismSpot,
          repository: repository,
        ),
    'label': instance.label,
    'image_url': instance.imageUrl,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

/// Construct a [TourismImageModel]
class TourismImageModelAdapter
    extends OfflineFirstWithSupabaseAdapter<TourismImageModel> {
  TourismImageModelAdapter();

  @override
  final supabaseTableName = 'tourism_images';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
    'tourismSpot': const RuntimeSupabaseColumnDefinition(
      association: true,
      columnName: 'tourism_spot',
      associationType: TourismSpotModel,
      associationIsNullable: false,
      foreignKey: 'tourism_spot_id',
    ),
    'tourismSpotId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'tourism_spot_id',
    ),
    'label': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'label',
    ),
    'imageUrl': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'image_url',
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
    'tourismSpot': const RuntimeSqliteColumnDefinition(
      association: true,
      columnName: 'tourism_spot_TourismSpotModel_brick_id',
      iterable: false,
      type: TourismSpotModel,
    ),
    'label': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'label',
      iterable: false,
      type: String,
    ),
    'imageUrl': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'image_url',
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
    TourismImageModel instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `TourismImageModel` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'TourismImageModel';

  @override
  Future<TourismImageModel> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageModelFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    TourismImageModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageModelToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<TourismImageModel> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageModelFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    TourismImageModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageModelToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
