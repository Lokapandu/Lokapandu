// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<ChatModel> _$ChatModelFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return ChatModel(
    id: data['id'] as String,
    userId: data['user_id'] as String,
    content: data['content'] as String,
    isFromUser: data['is_from_user'] as bool,
    createdAt: DateTime.parse(data['created_at'] as String),
  );
}

Future<Map<String, dynamic>> _$ChatModelToSupabase(
  ChatModel instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'user_id': instance.userId,
    'content': instance.content,
    'is_from_user': instance.isFromUser,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

Future<ChatModel> _$ChatModelFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return ChatModel(
    id: data['id'] as String,
    userId: data['user_id'] as String,
    content: data['content'] as String,
    isFromUser: data['is_from_user'] == 1,
    createdAt: DateTime.parse(data['created_at'] as String),
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$ChatModelToSqlite(
  ChatModel instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {
    'id': instance.id,
    'user_id': instance.userId,
    'content': instance.content,
    'is_from_user': instance.isFromUser ? 1 : 0,
    'created_at': instance.createdAt.toIso8601String(),
  };
}

/// Construct a [ChatModel]
class ChatModelAdapter extends OfflineFirstWithSupabaseAdapter<ChatModel> {
  ChatModelAdapter();

  @override
  final supabaseTableName = 'chat_messages';
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
    'content': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'content',
    ),
    'isFromUser': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'is_from_user',
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
    'content': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'content',
      iterable: false,
      type: String,
    ),
    'isFromUser': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'is_from_user',
      iterable: false,
      type: bool,
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
    ChatModel instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `ChatModel` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'ChatModel';

  @override
  Future<ChatModel> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ChatModelFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    ChatModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ChatModelToSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<ChatModel> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ChatModelFromSqlite(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSqlite(
    ChatModel input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$ChatModelToSqlite(
    input,
    provider: provider,
    repository: repository,
  );
}
