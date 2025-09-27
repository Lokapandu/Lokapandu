// REPOSITORY IMPLEMENTATION USING BRICK'S REPOSITORY
import 'dart:io';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/brick/models/tourism_spot.model.dart' as model;
import 'package:lokapandu/brick/models/tourism_image.model.dart' as image_model;
import 'package:lokapandu/data/mappers/tourism_spot_mapper.dart';
import 'package:lokapandu/data/mappers/tourism_image_mapper.dart';

import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class TourismSpotRepositoryImpl implements TourismSpotRepository {
  @override
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots() async {
    try {
      // Fetch tourism spots
      final spotsResult = await Repository().getAll<model.TourismSpotModel>();

      // Handle null result
      if (spotsResult == null) {
        return Left(ServerFailure('No data available'));
      }

      // Handle empty result
      if (spotsResult.isEmpty) {
        return Right([]);
      }

      // Fetch all tourism images
      final imagesResult = await Repository()
          .getAll<image_model.TourismImageModel>();

      // Group images by tourism spot ID
      final Map<int, List<TourismImage>> imagesMap = {};
      if (imagesResult != null) {
        for (final image in imagesResult) {
          final spotId = image.tourismSpotId;
          if (!imagesMap.containsKey(spotId)) {
            imagesMap[spotId] = [];
          }
          try {
            imagesMap[spotId]!.add(image.toEntity());
          } catch (e) {
            print('Error converting tourism image ${image.id}: $e');
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
          // Log individual spot conversion errors but continue processing
          print('Error converting tourism spot ${spot.id}: $e');
        }
      }

      return Right(entities);
    } on ServerException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Server error: ${e.toString()}'));
    } on SocketException catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ConnectionFailure('Connection error: ${e.toString()}'));
    } catch (e) {
      developer.log(e.toString(), name: "Tourism Spot Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
