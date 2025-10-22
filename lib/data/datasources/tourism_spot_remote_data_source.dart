import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';

// Abstract interface that defines contract for remote data source operations
abstract class TourismSpotRemoteDataSource {
  // Method to fetch all tourism spots from remote data source
  Future<List<TourismSpotModel>> getTourismSpots({String? query});

  // Method to fetch a specific tourism spot by its ID, returns null if not found
  Future<TourismSpotModel?> getTourismSpotById(int id);

  // Method to fetch all tourism images associated with a specific tourism spot
  Future<List<TourismImageModel>> getTourismImagesBySpotId(int spotId);

  // Method to fetch all tourism images from remote data source
  Future<List<TourismImageModel>> getAllTourismImages();
  Future<List<TourismSpotModel>> searchTourismSpots(String query);

  // Method to fetch tourism spots filtered by category
  Future<List<TourismSpotModel>> getTourismSpotsByCategory(String category);
}
