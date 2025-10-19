import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';

abstract class SupabaseServiceInterface {
  /// Retrieves all tourism spots from the database.
  ///
  /// Returns a [Future] that completes with a list of [TourismSpotModel].
  /// Throws [SupabaseException] if the database operation fails.
  /// Throws [ServerException] if there's a server-side error.
  Future<List<TourismSpotModel>> getAllTourismSpots();

  /// Retrieves a specific tourism spot by its ID.
  ///
  /// [id] The unique identifier of the tourism spot.
  /// Returns a [Future] that completes with a [TourismSpotModel] if found,
  /// or null if no spot exists with the given ID.
  /// Throws [SupabaseException] if the database operation fails.
  /// Throws [ServerException] if there's a server-side error.
  Future<TourismSpotModel?> getTourismSpotById(int id);

  /// Retrieves all tourism images for a specific tourism spot.
  ///
  /// [tourismSpotId] The ID of the tourism spot to get images for.
  /// Returns a [Future] that completes with a list of [TourismImageModel].
  /// Throws [SupabaseException] if the database operation fails.
  /// Throws [ServerException] if there's a server-side error.
  Future<List<TourismImageModel>> getTourismImagesBySpotId(int tourismSpotId);

  /// Retrieves all tourism images from the database.
  ///
  /// Returns a [Future] that completes with a list of [TourismImageModel].
  /// Throws [SupabaseException] if the database operation fails.
  /// Throws [ServerException] if there's a server-side error.
  Future<List<TourismImageModel>> getAllTourismImages();
  Future<List<TourismSpotModel>> searchTourismSpots(String query);

  /// Retrieves tourism spots filtered by category.
  ///
  /// [category] The category to filter by (e.g., 'Taman Budaya & Bersejarah').
  /// Returns a [Future] that completes with a list of [TourismSpotModel].
  /// Throws [SupabaseException] if the database operation fails.
  /// Throws [ServerException] if there's a server-side error.
  Future<List<TourismSpotModel>> getTourismSpotsByCategory(String category);
}
