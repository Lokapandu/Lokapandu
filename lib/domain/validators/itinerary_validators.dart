import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class ItineraryValidators {
  static const int _maxNameLength = 35;
  static const int _maxNotesLength = 250;
  static const int _bufferTimeMinutes = 1;

  final ItineraryRepository _repository;

  ItineraryValidators(this._repository);

  Either<Failure, Unit> validateTimeRange(
    DateTime startTime,
    DateTime endTime,
  ) {
    if (startTime.isAfter(endTime)) {
      return Left(
        InvalidTimeRangeFailure('Start time must be before end time'),
      );
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateFutureTime(DateTime startTime) {
    final now = DateTime.now();
    if (startTime.isBefore(now)) {
      return Left(ValidationFailure('Start time must be in the future'));
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateFieldLengths({
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

  Future<Either<Failure, Unit>> validateTourismSpotExists(
    int? tourismSpotId,
  ) async {
    if (tourismSpotId == null) {
      return Right(unit);
    }

    try {
      final result = await _repository.checkTourismSpotExists(tourismSpotId);

      return result.fold(
        (failure) => Left(failure),
        (exists) => exists
            ? Right(unit)
            : Left(ValidationFailure('Tourism spot not found')),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Validators");
      return Left(
        ServerFailure('Error validating tourism spot: ${e.toString()}'),
      );
    }
  }

  Future<Either<Failure, Unit>> checkSchedulingConflicts(
    String userId,
    DateTime startTime,
    DateTime endTime, [
    String? excludeItineraryId,
  ]) async {
    try {
      final result = await _repository.checkSchedulingConflicts(
        userId,
        startTime,
        endTime,
        excludeItineraryId,
      );

      return result.fold(
        (failure) => Left(failure),
        (hasConflict) => hasConflict
            ? Left(
                SchedulingConflictFailure(
                  'Cannot add itinerary - scheduling conflict detected. '
                  'Please ensure at least $_bufferTimeMinutes minutes gap between itineraries',
                ),
              )
            : Right(unit),
      );
    } catch (e) {
      developer.log(e.toString(), name: "Itinerary Validators");
      return Left(
        ServerFailure('Error checking scheduling conflicts: ${e.toString()}'),
      );
    }
  }

  Either<Failure, Unit> validateRequiredFields(CreateItinerary itineraryInput) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary name is required'));
    }
    return Right(unit);
  }

  Either<Failure, Unit> validateNoteRequiredFields(
    CreateItineraryNote itineraryInput,
  ) {
    if (itineraryInput.name.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary name is required'));
    } else if (itineraryInput.notes.trim().isEmpty) {
      return Left(MissingFieldFailure('Itinerary content is required'));
    }
    return Right(unit);
  }
}
