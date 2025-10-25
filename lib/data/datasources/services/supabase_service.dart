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
    int page = 1,
    int perPage = 10,
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

      final from = page * perPage;
      final to = from + perPage - 1;

      final response = await builder
          .range(from, to)
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
}
