import 'package:lokapandu/data/models/tourism_spot/ts_model/tourism_spot_model.dart';
import 'package:lokapandu/data/models/tourism_spot/ts_response/tourism_spot_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<TourismSpotModel>> getTourismSpots() async {
    final PostgrestList response = await supabase.from('tourism_spots').select(
      '''
          id,
          name,
          description,
          city,
          province,
          address,
          latitude,
          longitude,
          open_time,
          close_time,
          google_maps_link,
          images (id, label, file_name),
          facilities (id, name)
        ''',
    );

    return TourismSpotResponse.fromJson(
      response as Map<String, dynamic>,
    ).models;
  }
}
