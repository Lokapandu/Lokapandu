import 'dart:io';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/common/errors/exceptions.dart';

// Implementation class that acts as data source layer for tourism spots
class TourismSpotRemoteDataSourceImpl implements TourismSpotRemoteDataSource {
  final SupabaseServiceInterface _supabaseService;

  TourismSpotRemoteDataSourceImpl({
    required SupabaseServiceInterface supabaseService,
  }) : _supabaseService = supabaseService;

  // Method to fetch all tourism spots with comprehensive error handling
  @override
  Future<List<TourismSpotModel>> getTourismSpots() async {
    try {
      return await _supabaseService.getAllTourismSpots();
    } on SupabaseException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw ConnectionException('No internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch tourism spots: $e');
    }
  }

  // Method to fetch a specific tourism spot by ID with error handling
  @override
  Future<TourismSpotModel?> getTourismSpotById(int id) async {
    try {
      return await _supabaseService.getTourismSpotById(id);
    } on SupabaseException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw ConnectionException('No internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch tourism spot: $e');
    }
  }

  // Method to fetch all tourism images with error handling
  @override
  Future<List<TourismImageModel>> getAllTourismImages() async {
    try {
      return await _supabaseService.getAllTourismImages();
    } on SupabaseException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw ConnectionException('No internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch all tourism images: $e');
    }
  }

  // Method to fetch tourism images for a specific spot with error handling
  @override
  Future<List<TourismImageModel>> getTourismImagesBySpotId(int spotId) async {
    try {
      return await _supabaseService.getTourismImagesBySpotId(spotId);
    } on SupabaseException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw ConnectionException('No internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch tourism images: $e');
    }
  }
}
