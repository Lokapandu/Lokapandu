import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:lokapandu/brick/models/tourism_spot.model.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'tourism_images'),
)
class TourismImageModel extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final int id;

  @Supabase(foreignKey: 'tourism_spot_id')
  final TourismSpotModel tourismSpot;

  @Sqlite(ignore: true)
  int get tourismSpotId => tourismSpot.id;

  final String label;
  final String imageUrl;
  final DateTime createdAt;

  TourismImageModel({
    required this.id,
    required this.tourismSpot,
    required this.label,
    required this.imageUrl,
    required this.createdAt,
  });
}
