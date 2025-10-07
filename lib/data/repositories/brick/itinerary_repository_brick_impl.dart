import 'dart:developer' as developer;

import 'package:brick_core/query.dart';
import 'package:dartz/dartz.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:uuid/uuid.dart';

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

  @override
  Future<Either<Failure, Unit>> createItinerary(userId, itineraryInput) async {
    try {
      final itineraryModel = ItineraryModel(
        id: Uuid().v4(),
        name: itineraryInput.name,
        notes: itineraryInput.notes,
        startTime: itineraryInput.startTime,
        endTime: itineraryInput.endTime,
        createdAt: DateTime.now(),
        tourismSpotId: itineraryInput.tourismSpot,
      );

      final createdModel = await Repository().upsert<ItineraryModel>(
        itineraryModel,
      );

      await Repository().upsert<UserItineraryModel>(
        UserItineraryModel(
          id: Uuid().v4(),
          userId: userId,
          itinerariesId: createdModel.id,
          createdAt: DateTime.now(),
        ),
      );

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ConnectionFailure('Connection error: ${e.message}')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ServerFailure('Unexpected error: ${e.toString()}')),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> createItineraryNote(
    String userId,
    CreateItineraryNote itineraryNoteInput,
  ) async {
    try {
      final itineraryModel = ItineraryModel(
        id: Uuid().v4(),
        name: itineraryNoteInput.name,
        notes: itineraryNoteInput.notes,
        startTime: itineraryNoteInput.startTime,
        endTime: itineraryNoteInput.endTime,
        createdAt: DateTime.now(),
      );

      final createdModel = await Repository().upsert<ItineraryModel>(
        itineraryModel,
      );

      await Repository().upsert<UserItineraryModel>(
        UserItineraryModel(
          id: Uuid().v4(),
          userId: userId,
          itinerariesId: createdModel.id,
          createdAt: DateTime.now(),
        ),
      );

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ConnectionFailure('Connection error: ${e.message}')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ServerFailure('Unexpected error: ${e.toString()}')),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> editItinerary(EditItinerary itineraryInput) async {
    try {
      final existingItineraryResults = await Repository().getAll<ItineraryModel>(
        query: Query.where('id', itineraryInput.id),
      );

      if (existingItineraryResults == null ||
          existingItineraryResults.isEmpty) {
        return Future.value(
          Left(ServerFailure('Itinerary not found')),
        );
      }

      final existingItinerary = existingItineraryResults.first;

      final updatedItinerary = ItineraryModel(
        id: existingItinerary.id,
        name: itineraryInput.name ?? existingItinerary.name,
        notes: itineraryInput.notes ?? existingItinerary.notes,
        startTime: itineraryInput.startTime ?? existingItinerary.startTime,
        endTime: itineraryInput.endTime ?? existingItinerary.endTime,
        tourismSpotId:
            itineraryInput.tourismSpot ?? existingItinerary.tourismSpotId,
        createdAt: existingItinerary.createdAt,
      );

      await Repository().upsert<ItineraryModel>(updatedItinerary);

      return Future.value(Right(unit));
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ConnectionFailure('Connection error: ${e.message}')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ServerFailure('Unexpected error: ${e.toString()}')),
      );
    }
  }

    
  @override
  Future<Either<Failure, Unit>> deleteItinerary(String itineraryId) async {
    try {
      final existingItineraryResults = await Repository().getOne<ItineraryModel>(
        query: Query.where('id', itineraryId),
      );

      if (existingItineraryResults == null) {
        return Future.value(
          Left(ServerFailure('Itinerary not found')),
        );
      }

      return Repository().deleteOne<ItineraryModel>(existingItineraryResults).then((success) {
        if (success) {
          return Right(unit);
        } else {
          return Left(ServerFailure('Failed to delete itinerary'));
        }
      });
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ConnectionFailure('Connection error: ${e.message}')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Future.value(
        Left(ServerFailure('Unexpected error: ${e.toString()}')),
      );
    }
  }

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
