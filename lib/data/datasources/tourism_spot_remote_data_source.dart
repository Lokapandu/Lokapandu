import 'package:lokapandu/data/datasources/services/supabase_service.dart';
import 'package:lokapandu/data/models/tourism_spot/ts_model/tourism_spot_model.dart';

abstract class TourismSpotRemoteDataSource {
  Future<List<TourismSpotModel>> getTourismSpots();
}

class TourismSpotRemoteDataSourceImpl implements TourismSpotRemoteDataSource {
  final SupabaseService supabaseService;

  TourismSpotRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<List<TourismSpotModel>> getTourismSpots() async {
    return supabaseService.getTourismSpots();
  }
}
