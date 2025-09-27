import 'dart:io';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/common/exceptions.dart';
import 'package:lokapandu/data/datasources/tourism_spot_remote_data_source.dart';
import 'package:lokapandu/data/mappers/supabase_tourism_spot_mapper.dart';
import 'package:lokapandu/data/mappers/supabase_tourism_image_mapper.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class TourismSpotRepositorySupabaseImpl implements TourismSpotRepository {
  final TourismSpotRemoteDataSource _remoteDataSource;

  TourismSpotRepositorySupabaseImpl({
    required TourismSpotRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots() async {
    try {
      // Fetch tourism spots from Supabase
      final spotsResult = await _remoteDataSource.getTourismSpots();

      // Handle empty result
      if (spotsResult.isEmpty) {
        return Right([]);
      }

      // Fetch all tourism images from Supabase
      final imagesResult = await _remoteDataSource.getAllTourismImages();

      // Create a map of spots for image mapping
      final Map<int, TourismSpot> spotsMap = {};
      for (final spot in spotsResult) {
        spotsMap[spot.id] = spot.toEntity();
      }

      // Group images by tourism spot ID
      final Map<int, List<TourismImage>> imagesMap = {};
      for (final image in imagesResult) {
        final spotId = image.tourismSpotId;
        final spot = spotsMap[spotId];

        if (spot != null) {
          if (!imagesMap.containsKey(spotId)) {
            imagesMap[spotId] = [];
          }
          try {
            imagesMap[spotId]!.add(image.toEntity(spot));
          } catch (e) {
            developer.log(
              'Error converting tourism image ${image.id}: $e',
              name: "Tourism Spot Repository",
            );
          }
        }
      }

      // Map spots to entities with their associated images
      final entities = <TourismSpot>[];
      for (final spot in spotsResult) {
        try {
          final spotImages = imagesMap[spot.id] ?? [];
          entities.add(spot.toEntity(images: spotImages));
        } catch (e) {
          developer.log(
            'Error converting tourism spot ${spot.id}: $e',
            name: "Tourism Spot Repository",
          );
        }
      }

      return Right(entities);
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
}
