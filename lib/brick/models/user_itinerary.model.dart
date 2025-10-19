import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'user_itineraries'),
)
class UserItineraryModel extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  final String userId;
  final String itinerariesId;
  final DateTime createdAt;

  UserItineraryModel({
    required this.id,
    required this.userId,
    required this.itinerariesId,
    required this.createdAt,
  });
}
