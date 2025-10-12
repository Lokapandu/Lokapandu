import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'itineraries'),
)
class ItineraryModel extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  final String name;
  final String? notes;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime createdAt;

  final int? tourismSpotId;

  ItineraryModel({
    required this.id,
    required this.name,
    this.notes,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    this.tourismSpotId,
  });
}
