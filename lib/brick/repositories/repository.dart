import 'package:brick_offline_first/brick_offline_first.dart';
import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_sqlite/memory_cache_provider.dart';
import 'package:brick_supabase/brick_supabase.dart' hide Supabase;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../brick.g.dart';
import '../db/schema.g.dart';

class Repository extends OfflineFirstWithSupabaseRepository {
  static late Repository? _instance;

  Repository._({
    required super.supabaseProvider,
    required super.sqliteProvider,
    required super.migrations,
    required super.offlineRequestQueue,
    super.memoryCacheProvider,
  });

  factory Repository() => _instance!;

  static Future<void> configure({
    required String supabaseUrl,
    required String supabaseAnonKey,
    required DatabaseFactory databaseFactory,
  }) async {
    final (client, queue) = OfflineFirstWithSupabaseRepository.clientQueue(
      databaseFactory: databaseFactory,
    );

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      httpClient: client,
    );

    final provider = SupabaseProvider(
      Supabase.instance.client,
      modelDictionary: supabaseModelDictionary,
    );

    _instance = Repository._(
      supabaseProvider: provider,
      sqliteProvider: SqliteProvider(
        'lokapandu.sqlite',
        databaseFactory: databaseFactory,
        modelDictionary: sqliteModelDictionary,
      ),
      migrations: migrations,
      offlineRequestQueue: queue,
      memoryCacheProvider: MemoryCacheProvider(),
    );
  }

  Future<List<TModel>?> getAll<TModel extends OfflineFirstWithSupabaseModel>({
    Query? query,
    OfflineFirstGetPolicy policy =
        OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
  }) async {
    final results = await super.get<TModel>(policy: policy, query: query);
    return results.isNotEmpty ? results : null;
  }

  Future<TModel?> getOne<TModel extends OfflineFirstWithSupabaseModel>({
    Query? query,
    OfflineFirstGetPolicy policy =
        OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
  }) async {
    final results = await get<TModel>(policy: policy, query: query);
    return results.isNotEmpty ? results.first : null;
  }

  Future<TModel> upsertOne<TModel extends OfflineFirstWithSupabaseModel>(
    TModel instance, {
    Query? query,
    OfflineFirstUpsertPolicy policy = OfflineFirstUpsertPolicy.requireRemote,
  }) async {
    final results = await super.upsert<TModel>(
      instance,
      policy: policy,
      query: query,
    );
    return results;
  }

  Future<bool> deleteOne<TModel extends OfflineFirstWithSupabaseModel>(
    TModel instance, {
    Query? query,
    OfflineFirstDeletePolicy policy = OfflineFirstDeletePolicy.requireRemote,
  }) async {
    final results = await super.delete<TModel>(
      instance,
      policy: policy,
      query: query,
    );
    return results;
  }
}
