import 'dart:developer' as developer;
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/mappers/supabase_tourism_image_mapper.dart';
import 'package:lokapandu/data/mappers/supabase_tourism_spot_mapper.dart';
import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_image_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class TourismSpotRepositorySupabaseImpl implements TourismSpotRepository {
  final TourismSpotRemoteDataSource _remoteDataSource;

  TourismSpotRepositorySupabaseImpl({
    required TourismSpotRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<Either<Failure, List<TourismSpot>>> _executeSpotListCall(
    Future<List<TourismSpotModel>> Function() call,
  ) async {
    try {
      final spotsResult = await call();
      if (spotsResult.isEmpty) {
        return const Right([]);
      }
      final imagesResult = await _remoteDataSource.getAllTourismImages();
      return Right(_mapSpotsWithImages(spotsResult, imagesResult));
    } on SupabaseException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Supabase error: ${e.message}'));
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } on ServerException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Server error: ${e.message}'));
    } on SocketException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ConnectionFailure('Connection error: ${e.toString()}'));
    } catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots(
    String? query,
  ) async {
    return _executeSpotListCall(
      () => _remoteDataSource.getTourismSpots(query: query),
    );
  }

  @override
  Future<Either<Failure, List<TourismSpot>>> searchTourismSpots(
    String query,
  ) async {
    return _executeSpotListCall(
      () => _remoteDataSource.searchTourismSpots(query),
    );
  }

  @override
  Future<Either<Failure, List<TourismSpot>>> getTourismSpotsByCategory(
    String category,
  ) async {
    return _executeSpotListCall(
      () => _remoteDataSource.getTourismSpotsByCategory(category),
    );
  }

  // Fetching tourism spot lists
  @override
  Future<Either<Failure, TourismSpot>> getTourismSpotById(int id) async {
    try {
      // Fetch tourism spots from Supabase
      final spotResult = await _remoteDataSource.getTourismSpotById(id);

      // Handle empty result
      if (spotResult == null) {
        return Left(ServerFailure('Tourism spot with ID $id not found'));
      }
      // Fetch all tourism images from Supabase
      final imagesResult = await _remoteDataSource.getTourismImagesBySpotId(
        spotResult.id,
      );

      final spotEntityWithoutImages = spotResult.toEntity();
      final imageEntities = imagesResult.toEntityList({
        spotResult.id: spotEntityWithoutImages,
      });
      final spotEntity = spotResult.toEntity(images: imageEntities);

      return Right(spotEntity);
    } on SupabaseException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Supabase error: ${e.message}'));
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  List<TourismSpot> _mapSpotsWithImages(
    List<TourismSpotModel> spotsResult,
    List<TourismImageModel> imagesResult,
  ) {
    final Map<int, TourismSpot> spotsMap = {
      for (var spot in spotsResult) spot.id: spot.toEntity(),
    };

    final Map<int, List<TourismImage>> imagesMap = {};
    for (final image in imagesResult) {
      if (spotsMap.containsKey(image.tourismSpotId)) {
        imagesMap
            .putIfAbsent(image.tourismSpotId, () => [])
            .add(image.toEntity());
      }
    }

    return spotsResult.toEntityList(imagesMap: imagesMap);
  }
}
