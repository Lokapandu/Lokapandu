// ignore: unused_import, unused_shown_name, unnecessary_import
import 'package:brick_core/query.dart';
// ignore: unused_import, unused_shown_name, unnecessary_import
import 'package:brick_sqlite/db.dart';
// ignore: unused_import, unused_shown_name, unnecessary_import
import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
// ignore: unused_import, unused_shown_name, unnecessary_import
import 'package:brick_sqlite/brick_sqlite.dart';
// ignore: unused_import, unused_shown_name, unnecessary_import
import 'package:brick_supabase/brick_supabase.dart';// GENERATED CODE DO NOT EDIT
// ignore: unused_import
import 'dart:convert';
import 'package:brick_sqlite/brick_sqlite.dart' show SqliteModel, SqliteAdapter, SqliteModelDictionary, RuntimeSqliteColumnDefinition, SqliteProvider;
import 'package:brick_supabase/brick_supabase.dart' show SupabaseProvider, SupabaseModel, SupabaseAdapter, SupabaseModelDictionary;
// ignore: unused_import, unused_shown_name
import 'package:brick_offline_first/brick_offline_first.dart' show RuntimeOfflineFirstDefinition;
// ignore: unused_import, unused_shown_name
import 'package:sqflite_common/sqlite_api.dart' show DatabaseExecutor;

import '../brick/models/itinerary.model.dart';
import '../brick/models/tourism_image.model.dart';
import '../brick/models/tourism_spot.model.dart';
import '../brick/models/chat.model.dart';

part 'adapters/itinerary_model_adapter.g.dart';
part 'adapters/tourism_image_model_adapter.g.dart';
part 'adapters/tourism_spot_model_adapter.g.dart';
part 'adapters/chat_model_adapter.g.dart';

/// Supabase mappings should only be used when initializing a [SupabaseProvider]
final Map<Type, SupabaseAdapter<SupabaseModel>> supabaseMappings = {
  ItineraryModel: ItineraryModelAdapter(),
  TourismImageModel: TourismImageModelAdapter(),
  TourismSpotModel: TourismSpotModelAdapter(),
  ChatModel: ChatModelAdapter()
};
final supabaseModelDictionary = SupabaseModelDictionary(supabaseMappings);

/// Sqlite mappings should only be used when initializing a [SqliteProvider]
final Map<Type, SqliteAdapter<SqliteModel>> sqliteMappings = {
  ItineraryModel: ItineraryModelAdapter(),
  TourismImageModel: TourismImageModelAdapter(),
  TourismSpotModel: TourismSpotModelAdapter(),
  ChatModel: ChatModelAdapter()
};
final sqliteModelDictionary = SqliteModelDictionary(sqliteMappings);
