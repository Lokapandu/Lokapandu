import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';

abstract class SupabaseServiceInterface {
  Future<List<TourismSpotModel>> getAllTourismSpots();
  Future<TourismSpotModel?> getTourismSpotById(int id);
  Future<List<TourismImageModel>> getTourismImagesBySpotId(int tourismSpotId);
  Future<List<TourismImageModel>> getAllTourismImages();
  Future<List<TourismSpotModel>> searchTourismSpots(String query);
}