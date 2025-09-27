import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/common/errors/exceptions.dart';

// Service class that handles all Supabase database operations
class SupabaseService implements SupabaseServiceInterface {
  static SupabaseService? _instance;
  late final SupabaseClient _client;

  SupabaseService._() {
    _client = Supabase.instance.client;
  }

  factory SupabaseService() {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  SupabaseClient get client => _client;

  // Method to fetch all tourism spots from database
  @override
  Future<List<TourismSpotModel>> getAllTourismSpots() async {
    try {
      final response = await _client
          .from('tourism_spots')
          .select('*')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TourismSpotModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw SupabaseException(
        'Failed to fetch tourism spots: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error while fetching tourism spots: $e',
      );
    }
  }

  // Method to fetch a single tourism spot by its ID
  @override
  Future<TourismSpotModel?> getTourismSpotById(int id) async {
    try {
      final response = await _client
          .from('tourism_spots')
          .select('*')
          .eq('id', id)
          .maybeSingle();

      if (response == null) return null;

      return TourismSpotModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw SupabaseException(
        'Failed to fetch tourism spot with id $id: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ServerException('Unexpected error while fetching tourism spot: $e');
    }
  }

  // Method to fetch all tourism images from database
  @override
  Future<List<TourismImageModel>> getAllTourismImages() async {
    try {
      final response = await _client
          .from('tourism_images')
          .select('*')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TourismImageModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw SupabaseException(
        'Failed to fetch tourism images: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error while fetching tourism images: $e',
      );
    }
  }

  // Method to fetch tourism images for a specific tourism spot
  @override
  Future<List<TourismImageModel>> getTourismImagesBySpotId(int spotId) async {
    try {
      final response = await _client
          .from('tourism_images')
          .select('*')
          .eq('tourism_spot_id', spotId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TourismImageModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw SupabaseException(
        'Failed to fetch tourism images for spot $spotId: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      throw ServerException(
        'Unexpected error while fetching tourism images: $e',
      );
    }
  }
}
