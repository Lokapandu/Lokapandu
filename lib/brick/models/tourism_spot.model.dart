import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'tourism_spots'),
)
class TourismSpot extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final int id;

  final String name;
  final String description;
  final String city;
  final String province;
  final String category;
  final String address;
  final double latitude;
  final double longitude;
  final String openTime;
  final String closeTime;
  final String mapsLink;
  final String facilities;
  final DateTime createdAt;

  TourismSpot({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.province,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.openTime,
    required this.closeTime,
    required this.mapsLink,
    required this.facilities,
    required this.createdAt,
  });
}
