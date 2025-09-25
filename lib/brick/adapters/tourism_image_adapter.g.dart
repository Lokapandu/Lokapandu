// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<TourismImage> _$TourismImageFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismImage(
    id: data['id'] as int,
    tourismSpot: await TourismSpotAdapter().fromSupabase(
      data['tourism_spot'],
      provider: provider,
      repository: repository,
    ),
    label: data['label'] as String,
    imageUrl: data['image_url'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  );
}

Future<Map<String, dynamic>> _$TourismImageToSupabase(
  TourismImage instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'tourism_spot': await TourismSpotAdapter().toSupabase(
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

Future<TourismImage> _$TourismImageFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return TourismImage(
    id: data['id'] as int,
    tourismSpot: (await repository!.getAssociation<TourismSpot>(
      Query.where(
        'primaryKey',
        data['tourism_spot_TourismSpot_brick_id'] as int,
        limit1: true,
      ),
    ))!.first,
    label: data['label'] as String,
    imageUrl: data['image_url'] as String,
    createdAt: DateTime.parse(data['created_at'] as String),
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$TourismImageToSqlite(
  TourismImage instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'tourism_spot_TourismSpot_brick_id':
        instance.tourismSpot.primaryKey ??
        await provider.upsert<TourismSpot>(
          instance.tourismSpot,
          repository: repository,
        ),
    'label': instance.label,
    'image_url': instance.imageUrl,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

/// Construct a [TourismImage]
class TourismImageAdapter
    extends OfflineFirstWithSupabaseAdapter<TourismImage> {
  TourismImageAdapter();

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
      associationType: TourismSpot,
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
      columnName: 'tourism_spot_TourismSpot_brick_id',
      iterable: false,
      type: TourismSpot,
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
    TourismImage instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `TourismImage` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'TourismImage';

  @override
  Future<TourismImage> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    TourismImage input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<TourismImage> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    TourismImage input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$TourismImageToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
