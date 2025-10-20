import 'dart:developer' as developer;

import 'package:brick_offline_first/brick_offline_first.dart';
import 'package:dartz/dartz.dart';
import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/brick/models/tourism_image.model.dart';
import 'package:lokapandu/brick/models/tourism_spot.model.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/data/mappers/itinerary_mapper.dart';
import 'package:lokapandu/data/mappers/tourism_image_mapper.dart';
import 'package:lokapandu/data/mappers/tourism_spot_mapper.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:uuid/uuid.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  @override
  Future<Either<Failure, Itinerary>> getItineraryById(
    String itineraryId,
  ) async {
    try {
      final itineraryResults = await Repository().getAll<ItineraryModel>(
        query: Query.where('id', itineraryId),
        policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
      );

      if (itineraryResults == null || itineraryResults.isEmpty) {
        return Left(ServerFailure('Itinerary not found'));
      }

      final itineraryModel = itineraryResults.first;
      final itineraryEntities = await _toEntitiesWithRelations([
        itineraryModel,
      ]);

      return Right(itineraryEntities.first);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> getUserIdByItineraryId(
    String itineraryId,
  ) async {
    try {
      final itineraryResults = await Repository().getAll<ItineraryModel>(
        query: Query.where('id', itineraryId),
        policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
      );

      if (itineraryResults == null || itineraryResults.isEmpty) {
        return Left(ServerFailure('User itinerary association not found'));
      }

      return Right(itineraryResults.first.userId);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTourismSpotExists(
    int tourismSpotId,
  ) async {
    try {
      final tourismSpotResult = await Repository().getAll<TourismSpotModel>(
        query: Query.where('id', tourismSpotId),
      );

      if (tourismSpotResult == null || tourismSpotResult.isEmpty) {
        return Right(false);
      }

      return Right(true);
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(
        ServerFailure('Error checking tourism spot: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkSchedulingConflicts(
    String userId,
    DateTime startTime,
    DateTime endTime, [
    String? excludeItineraryId,
  ]) async {
    try {
      final userItineraryResults = await Repository().getAll<ItineraryModel>(
        query: Query.where('userId', userId),
        policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
      );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return Right(false);
      }

      final itineraryIds = userItineraryResults.map((e) => e.id).toList();

      if (itineraryIds.isEmpty) return Right(false);

      final itineraries = <ItineraryModel>[];

      for (final id in itineraryIds) {
        final result = await Repository().getAll<ItineraryModel>(
          query: Query.where('id', id),
        );
        if (result != null && result.isNotEmpty) {
          itineraries.add(result.first);
        }
      }

      if (itineraries.isEmpty) return Right(false);

      for (final itinerary in itineraries) {
        if (excludeItineraryId != null && itinerary.id == excludeItineraryId) {
          continue;
        }

        if (startTime.isBefore(itinerary.endTime) &&
            endTime.isAfter((itinerary.startTime))) {
          return Right(true);
        }
      }

      return Right(false);
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(
        ServerFailure('Error checking scheduling conflicts: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(
    String userId,
  ) async {
    try {
      final userItineraryResults = await Repository().getAll<ItineraryModel>(
        query: Query.where('userId', userId),
        policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
      );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return const Right([]);
      }

      final itineraryIds = userItineraryResults.map((e) => e.id).toList();

      developer.log(
        "Total itinerary IDs: ${itineraryIds.length}",
        name: "Itinerary Repository",
      );

      developer.log(
        "Itinerary IDs: $itineraryIds.toString()",
        name: "Itinerary Repository",
      );

      if (itineraryIds.isEmpty) {
        return const Right([]);
      }

      final itineraries = <ItineraryModel>[];

      for (final id in itineraryIds) {
        final result = await Repository().getAll<ItineraryModel>(
          query: Query.where('id', id),
          policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
        );
        if (result != null && result.isNotEmpty) {
          itineraries.add(result.first);
        }
      }

      developer.log('Manually fetched: ${itineraries.length}', name: 'Debug');

      if (itineraries.isEmpty) {
        return const Right([]);
      }

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
  Future<Either<Failure, Unit>> createItinerary(
    CreateItinerary itineraryInput,
  ) async {
    try {
      final itineraryModel = ItineraryModel(
        id: Uuid().v4(),
        name: itineraryInput.name,
        notes: itineraryInput.notes,
        startTime: itineraryInput.startTime,
        endTime: itineraryInput.endTime,
        createdAt: DateTime.now(),
        tourismSpotId: itineraryInput.tourismSpot,
        userId: itineraryInput.userId,
      );

      await Repository().upsertOne<ItineraryModel>(itineraryModel);

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> createItineraryNote(
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
        userId: itineraryNoteInput.userId,
      );

      await Repository().upsertOne<ItineraryModel>(itineraryModel);

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } on ValidationException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ValidationFailure(e.message));
    } on SchedulingConflictException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(SchedulingConflictFailure(e.message));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> editItinerary(
    EditItinerary itineraryInput,
  ) async {
    try {
      final existingItineraryResults = await Repository()
          .getAll<ItineraryModel>(
            query: Query.where('id', itineraryInput.id),
            policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
          );
      developer.log(
        "Total fetched: ${existingItineraryResults?.length}",
        name: "Itinerary Repository",
      );

      if (existingItineraryResults == null ||
          existingItineraryResults.isEmpty) {
        return Left(ServerFailure('Itinerary not found'));
      }

      final existingItinerary = existingItineraryResults.first;

      final finalName = itineraryInput.name ?? existingItinerary.name;
      final finalNotes = itineraryInput.notes ?? existingItinerary.notes;
      final finalStartTime =
          itineraryInput.startTime ?? existingItinerary.startTime;
      final finalEndTime = itineraryInput.endTime ?? existingItinerary.endTime;
      final finalTourismSpotId =
          itineraryInput.tourismSpot ?? existingItinerary.tourismSpotId;
      final finalUserId = itineraryInput.userId ?? existingItinerary.userId;

      final updatedItinerary = ItineraryModel(
        id: existingItinerary.id,
        name: finalName,
        notes: finalNotes,
        startTime: finalStartTime,
        endTime: finalEndTime,
        tourismSpotId: finalTourismSpotId,
        userId: finalUserId,
        createdAt: existingItinerary.createdAt,
      );

      await Repository().upsertOne<ItineraryModel>(updatedItinerary);

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItinerary(String itineraryId) async {
    try {
      final existingItineraryResults = await Repository()
          .getOne<ItineraryModel>(query: Query.where('id', itineraryId));

      if (existingItineraryResults == null) {
        return Left(ServerFailure('Itinerary not found'));
      }

      await Repository().delete<ItineraryModel>(existingItineraryResults);

      return Right(unit);
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
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
          policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
        );

        if (tourismSpotResult != null && tourismSpotResult.isNotEmpty) {
          final tourismSpotModel = tourismSpotResult.first;

          final tourismImageResults = await Repository()
              .getAll<TourismImageModel>(
                query: Query.where('tourismSpotId', tourismSpotModel.id),
                policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
              );

          final tourismImageEntities =
              tourismImageResults?.toEntityList() ?? [];

          tourismSpotEntity = tourismSpotModel.toEntity(
            images: tourismImageEntities,
          );
        }
      }

      return itinerary.toEntity(tourismSpot: tourismSpotEntity);
    });

    return Future.wait(itineraryEntitiesFutures);
  }
}
