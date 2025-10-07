import 'dart:developer' as developer;

import 'package:brick_core/query.dart';
import 'package:dartz/dartz.dart';

import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/brick/models/tourism_image.model.dart';
import 'package:lokapandu/brick/models/tourism_spot.model.dart';
import 'package:lokapandu/brick/models/user_itinerary.model.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/mappers/itinerary_mapper.dart';
import 'package:lokapandu/data/mappers/tourism_image_mapper.dart';
import 'package:lokapandu/data/mappers/tourism_spot_mapper.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  @override
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(
    String userId,
  ) async {
    try {
      // Fetch user itineraries
      final userItineraryResults = await Repository()
          .getAll<UserItineraryModel>(query: Query.where('userId', userId));

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return const Right([]);
      }

      // Extract itinerary IDs
      final itineraryIds = userItineraryResults
          .map((e) => e.itinerariesId)
          .toList();

      if (itineraryIds.isEmpty) {
        return const Right([]);
      }

      // Fetch itineraries by IDs
      final itineraries = await Repository().getAll<ItineraryModel>(
        query: Query(
          where: [
            WherePhrase(
              itineraryIds.map((id) => Where('id').isExactly(id)).toList(),
              isRequired: false,
            ),
          ],
        ),
      );

      if (itineraries == null || itineraries.isEmpty) {
        return const Right([]);
      }

      // Map to entities with relations
      final itineraryEntities = await _toEntitiesWithRelations(itineraries);

      return Right(itineraryEntities);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  /// Private helper to map itineraries to entities, fetching and attaching relations.
  Future<List<Itinerary>> _toEntitiesWithRelations(
    List<ItineraryModel> itineraries,
  ) async {
    final itineraryEntitiesFutures = itineraries.map((itinerary) async {
      TourismSpot? tourismSpotEntity;
      if (itinerary.tourismSpotId != null) {
        final tourismSpotResult = await Repository().getAll<TourismSpotModel>(
          query: Query.where('id', itinerary.tourismSpotId),
        );

        if (tourismSpotResult != null && tourismSpotResult.isNotEmpty) {
          final tourismSpotModel = tourismSpotResult.first;

          // Fetch associated images
          final tourismImageResults = await Repository()
              .getAll<TourismImageModel>(
                query: Query.where('tourismSpotId', tourismSpotModel.id),
              );

          final tourismImageEntities =
              tourismImageResults?.toEntityList() ?? [];

          // Map spot with images
          tourismSpotEntity = tourismSpotModel.toEntity(
            images: tourismImageEntities,
          );
        }
      }

      // Map itinerary
      return itinerary.toEntity(tourismSpot: tourismSpotEntity);
    }).toList();

    return Future.wait(itineraryEntitiesFutures);
  }
}
