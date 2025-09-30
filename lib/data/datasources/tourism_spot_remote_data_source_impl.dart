import 'dart:io';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/common/errors/exceptions.dart';

class TourismSpotRemoteDataSourceImpl implements TourismSpotRemoteDataSource {
  final SupabaseServiceInterface _supabaseService;

  TourismSpotRemoteDataSourceImpl({
    required SupabaseServiceInterface supabaseService,
  }) : _supabaseService = supabaseService;

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

  @override
  Future<List<TourismSpotModel>> searchTourismSpots(String query) async {
    try {
      return await _supabaseService.searchTourismSpots(query);
    } on SupabaseException {
      rethrow;
    } on ServerException {
      rethrow;
    } on SocketException {
      throw ConnectionException('No internet connection');
    } catch (e) {
      throw ServerException('Failed to search tourism spots: $e');
    }
  }
}