import 'package:dartz/dartz.dart';
import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/brick/models/tourism_spot.model.dart';
import 'package:lokapandu/brick/models/user_itinerary.model.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'dart:developer' as developer;
import 'package:lokapandu/common/errors/failure.dart';
import 'package:brick_offline_first/brick_offline_first.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';

class ItineraryValidators {
  static const int _maxNameLength = 35;
  static const int _maxNotesLength = 250;
  static const int _bufferTimeMinutes = 1;

  static Either<Failure, Unit> validateTimeRange(DateTime startTime, DateTime endTime) {
    if (startTime.isAfter(endTime)) {
      return Left(InvalidTimeRangeFailure('Start time must be before end time'));
    }
    return Right(unit);
  }

  static Either<Failure, Unit> validateFutureTime(DateTime startTime) {
    final now = DateTime.now();
    if (startTime.isBefore(now)) {
      return Left(ValidationFailure('Start time must be in the future'));
    }
    return Right(unit);
  }

  static Either<Failure, Unit> validateFieldLengths({
    required String name,
    String? notes,
  }) {
    if (name.length > _maxNameLength) {
      return Left(
        ValidationFailure('Name must not exceed $_maxNameLength characters'),
      );
    }

    if (notes != null && notes.length > _maxNotesLength) {
      return Left(
        ValidationFailure('Notes must not exceed $_maxNotesLength characters'),
      );
    }

    return Right(unit);
  }

  static Future<Either<Failure, Unit>> validateTourismSpotExists(int? tourismSpotId) async {
    if (tourismSpotId == null) {
      return Right(unit);
    }

    try {
      final tourismSpotResult = await Repository().getAll<TourismSpotModel>(
        query: Query.where('id', tourismSpotId),
      );

      if (tourismSpotResult == null || tourismSpotResult.isEmpty) {
        return Left(ValidationFailure('Tourism spot not found'));
      }

      return Right(unit);
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Error validating tourism spot: ${e.toString()}'));
    }
  }

  static Future<Either<Failure, Unit>> checkSchedulingConflicts(
    String userId,
    DateTime startTime,
    DateTime endTime, [
    String? excludeItineraryId,
  ]) async {
    try {
      final userItineraryResults = await Repository().getAll<UserItineraryModel>(
        query: Query.where('userId', userId),
        policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
      );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return Right(unit);
      }

      final itineraryIds = userItineraryResults.map((e) => e.itinerariesId).toList();

      if (itineraryIds.isEmpty) return Right(unit);

      final itineraries = <ItineraryModel>[];

      for (final id in itineraryIds) {
        final result = await Repository().getAll<ItineraryModel>(
          query: Query.where('id', id),
        );
        if (result != null && result.isNotEmpty) {
          itineraries.add(result.first);
        }
      }

      developer.log("Total itineraries fetched: ${itineraries.length}", name: "Itinerary Repository");

      if (itineraries.isEmpty) return Right(unit);

      final bufferedStartTime = startTime.subtract(Duration(minutes: _bufferTimeMinutes));
      final bufferedEndTime = endTime.add(Duration(minutes: _bufferTimeMinutes));

      for (final itinerary in itineraries) {
        if (excludeItineraryId != null && itinerary.id == excludeItineraryId) continue;

        if (bufferedStartTime.isBefore(itinerary.endTime) &&
            bufferedEndTime.isAfter(itinerary.startTime)) {
          return Left(
            SchedulingConflictFailure(
              'Cannot add itinerary - scheduling conflict detected. '
              'Please ensure at least $_bufferTimeMinutes minutes gap between itineraries',
            ),
          );
        }
      }

      return Right(unit);
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Repository");
      return Left(ServerFailure('Error checking scheduling conflicts: ${e.toString()}'));
    }
  }

  static Either<Failure, Unit> validateRequiredFields(CreateItinerary itineraryInput) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary name is required'));
    }
    return Right(unit);
  }

  static Either<Failure, Unit> validateNoteRequiredFields(CreateItineraryNote itineraryInput) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary name is required'));
    } else if (itineraryInput.notes.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary content is required'));
    }
    return Right(unit);
  }
}
