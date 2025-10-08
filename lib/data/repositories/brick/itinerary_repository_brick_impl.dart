import 'dart:developer' as developer;

import 'package:brick_offline_first/brick_offline_first.dart';
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
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:uuid/uuid.dart';

part 'itinerary_repository_helpers.dart';

class ItineraryRepositoryImpl implements ItineraryRepository {
  @override
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(
    String userId,
  ) async {
    try {
      // Fetch user itineraries
      final userItineraryResults = await Repository()
          .getAll<UserItineraryModel>(
            query: Query.where('userId', userId),
            policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
          );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return const Right([]);
      }

      // Extract itinerary IDs
      final itineraryIds = userItineraryResults
          .map((e) => e.itinerariesId)
          .toList();

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
  Future<Either<Failure, Unit>> createItinerary(
    String userId,
    CreateItinerary itineraryInput,
  ) async {
    try {
      // Validate required fields
      final requiredFieldsValidation = _validateRequiredFields(itineraryInput);
      if (requiredFieldsValidation.isLeft()) {
        return requiredFieldsValidation;
      }

      // Validate field lengths
      final fieldLengthValidation = _validateFieldLengths(
        name: itineraryInput.name,
        notes: itineraryInput.notes,
      );
      if (fieldLengthValidation.isLeft()) {
        return fieldLengthValidation;
      }

      // Validate start time is in the future
      final futureTimeValidation = _validateFutureTime(
        itineraryInput.startTime,
      );
      if (futureTimeValidation.isLeft()) {
        return futureTimeValidation;
      }

      // Validate time range
      final timeRangeValidation = _validateTimeRange(
        itineraryInput.startTime,
        itineraryInput.endTime,
      );
      if (timeRangeValidation.isLeft()) {
        return timeRangeValidation;
      }

      final tourismSpotValidation = await _validateTourismSpotExists(
        itineraryInput.tourismSpot,
      );
      if (tourismSpotValidation.isLeft()) {
        return tourismSpotValidation;
      }

      // Check for scheduling conflicts
      final conflictCheck = await _checkSchedulingConflicts(
        userId,
        itineraryInput.startTime,
        itineraryInput.endTime,
      );
      if (conflictCheck.isLeft()) {
        return conflictCheck;
      }

      final itineraryModel = ItineraryModel(
        id: Uuid().v4(),
        name: itineraryInput.name,
        notes: itineraryInput.notes,
        startTime: itineraryInput.startTime,
        endTime: itineraryInput.endTime,
        createdAt: DateTime.now(),
        tourismSpotId: itineraryInput.tourismSpot,
      );

      final createdModel = await Repository().upsertOne<ItineraryModel>(
        itineraryModel,
      );

      await Repository().upsertOne<UserItineraryModel>(
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
  Future<Either<Failure, Unit>> createItineraryNote(
    String userId,
    CreateItineraryNote itineraryNoteInput,
  ) async {
    try {
      // Validate required fields
      final requiredFieldsValidation = _validateNoteRequiredFields(
        itineraryNoteInput,
      );
      if (requiredFieldsValidation.isLeft()) {
        return requiredFieldsValidation;
      }

      // Validate field lengths
      final fieldLengthValidation = _validateFieldLengths(
        name: itineraryNoteInput.name,
        notes: itineraryNoteInput.notes,
      );
      if (fieldLengthValidation.isLeft()) {
        return fieldLengthValidation;
      }

      // Validate start time is in the future
      final futureTimeValidation = _validateFutureTime(
        itineraryNoteInput.startTime,
      );
      if (futureTimeValidation.isLeft()) {
        return futureTimeValidation;
      }

      // Validate time range
      final timeRangeValidation = _validateTimeRange(
        itineraryNoteInput.startTime,
        itineraryNoteInput.endTime,
      );
      if (timeRangeValidation.isLeft()) {
        return timeRangeValidation;
      }

      // Check for scheduling conflicts
      final conflictCheck = await _checkSchedulingConflicts(
        userId,
        itineraryNoteInput.startTime,
        itineraryNoteInput.endTime,
      );
      if (conflictCheck.isLeft()) {
        return conflictCheck;
      }

      final itineraryModel = ItineraryModel(
        id: Uuid().v4(),
        name: itineraryNoteInput.name,
        notes: itineraryNoteInput.notes,
        startTime: itineraryNoteInput.startTime,
        endTime: itineraryNoteInput.endTime,
        createdAt: DateTime.now(),
      );

      final createdModel = await Repository().upsertOne<ItineraryModel>(
        itineraryModel,
      );

      await Repository().upsertOne<UserItineraryModel>(
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

      // Get the user ID for this itinerary to check conflicts
      final userItineraryResults = await Repository()
          .getAll<UserItineraryModel>(
            query: Query.where('itinerariesId', itineraryInput.id),
            policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
          );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return Left(ServerFailure('User itinerary association not found'));
      }

      final userId = userItineraryResults.first.userId;

      // Determine the final values for validation
      final finalName = itineraryInput.name ?? existingItinerary.name;
      final finalNotes = itineraryInput.notes ?? existingItinerary.notes;
      final finalStartTime =
          itineraryInput.startTime ?? existingItinerary.startTime;
      final finalEndTime = itineraryInput.endTime ?? existingItinerary.endTime;
      final finalTourismSpotId =
          itineraryInput.tourismSpot ?? existingItinerary.tourismSpotId;

      // Validate field lengths
      final fieldLengthValidation = _validateFieldLengths(
        name: finalName,
        notes: finalNotes,
      );
      if (fieldLengthValidation.isLeft()) {
        return fieldLengthValidation;
      }

      // Validate tourism spot exists if being updated
      if (itineraryInput.tourismSpot != null) {
        final tourismSpotValidation = await _validateTourismSpotExists(
          itineraryInput.tourismSpot,
        );
        if (tourismSpotValidation.isLeft()) {
          return tourismSpotValidation;
        }
      }

      // Validate time range and conflicts if either start or end time is being updated
      if (itineraryInput.startTime != null || itineraryInput.endTime != null) {
        // Validate start time is in the future (only if being updated)
        if (itineraryInput.startTime != null) {
          final futureTimeValidation = _validateFutureTime(finalStartTime);
          if (futureTimeValidation.isLeft()) {
            return futureTimeValidation;
          }
        }

        final timeRangeValidation = _validateTimeRange(
          finalStartTime,
          finalEndTime,
        );
        if (timeRangeValidation.isLeft()) {
          return timeRangeValidation;
        }

        // Check for scheduling conflicts with other itineraries
        final conflictCheck = await _checkSchedulingConflicts(
          userId,
          finalStartTime,
          finalEndTime,
          itineraryInput.id, // Exclude current itinerary from conflict check
        );
        if (conflictCheck.isLeft()) {
          return conflictCheck;
        }
      }

      final updatedItinerary = ItineraryModel(
        id: existingItinerary.id,
        name: finalName,
        notes: finalNotes,
        startTime: finalStartTime,
        endTime: finalEndTime,
        tourismSpotId: finalTourismSpotId,
        createdAt: existingItinerary.createdAt,
      );

      await Repository().upsertOne<ItineraryModel>(updatedItinerary);

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
  Future<Either<Failure, Unit>> deleteItinerary(String itineraryId) async {
    try {
      final existingItineraryResults = await Repository()
          .getOne<ItineraryModel>(query: Query.where('id', itineraryId));

      if (existingItineraryResults == null) {
        return Left(ServerFailure('Itinerary not found'));
      }

      final userItineraryResult = await Repository().getOne<UserItineraryModel>(
        query: Query.where('itinerariesId', itineraryId),
      );
      if (userItineraryResult != null) {
        final deletedUserItinerary = await Repository()
            .deleteOne<UserItineraryModel>(userItineraryResult);
        if (!deletedUserItinerary) {
          developer.log(
            'Failed to delete user itinerary association locally for itineraryId: $itineraryId',
            name: 'Itinerary Repository',
          );
        }
      } else {
        return Left(ServerFailure('User Itinerary not found'));
      }
      return Repository()
          .deleteOne<ItineraryModel>(existingItineraryResults)
          .then((success) {
            if (success) {
              return Right(unit);
            } else {
              return Left(ServerFailure('Failed to delete itinerary'));
            }
          });
    } on ConnectionException catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ConnectionFailure('Connection error: ${e.message}'));
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
