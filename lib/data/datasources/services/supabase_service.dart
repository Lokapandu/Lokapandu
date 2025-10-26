import 'dart:developer' as dev;

import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/data/datasources/services/supabase_service_interface.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  Future<List<TourismSpotModel>> getAllTourismSpots({
    String? query,
    String? category,
    required int page,
    required int perPage,
  }) async {
    try {
      var builder = _client.from('tourism_spots').select('*');

      if (query != null) {
        builder = builder.ilike('name', '%$query%');
      }

      if (category != null) {
        if (category != 'Semua') {
          builder = builder.eq('category', category);
        }
      }

      // Perbaikan perhitungan range untuk pagination
      // Page dimulai dari 1, jadi kita perlu mengurangi 1 untuk perhitungan offset
      final offset = (page - 1) * perPage;
      final limit = perPage;

      print("PAGINATION DEBUG: page=$page, perPage=$perPage, offset=$offset, limit=$limit");

      final response = await builder
          .range(offset, offset + limit - 1)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TourismSpotModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw SupabaseException(
        'Failed to fetch tourism spots: ${e.message}',
        code: e.code,
      );
    } catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw ServerException(
        'Unexpected error while fetching tourism spots: $e',
      );
    }
  }

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
    } on PostgrestException catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw SupabaseException(
        'Failed to fetch tourism spot with id $id: ${e.message}',
        code: e.code,
      );
    } catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw ServerException('Unexpected error while fetching tourism spot: $e');
    }
  }

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
    } on PostgrestException catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw SupabaseException(
        'Failed to fetch tourism images: ${e.message}',
        code: e.code,
      );
    } catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw ServerException(
        'Unexpected error while fetching tourism images: $e',
      );
    }
  }

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
    } on PostgrestException catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw SupabaseException(
        'Failed to fetch tourism images for spot $spotId: ${e.message}',
        code: e.code,
      );
    } catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw ServerException(
        'Unexpected error while fetching tourism images: $e',
      );
    }
  }

  @override
  Future<int> countTourismSpot({String? search, String? category}) async {
    try {
      var query = _client.from('tourism_spots').select('id');

      if (search != null && search.isNotEmpty) {
        query = query.ilike('name', '%$search%');
      }

      if (category != null && category != 'Semua') {
        query = query.eq('category', category);
      }

      final response = await query.count(CountOption.exact);

      return response.count;
    } on PostgrestException catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw SupabaseException(
        'Failed to fetch tourism images count!',
        code: e.code,
      );
    } catch (e, st) {
      dev.log(
        e.toString(),
        time: DateTime.now(),
        name: 'SupabaseService',
        error: e,
        stackTrace: st,
      );
      throw ServerException(
        'Unexpected error while fetching tourism images: $e',
      );
    }
  }
}
