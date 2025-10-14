import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';

/// Use case for editing an existing user itinerary.
///
/// This class handles the business logic for editing an itinerary,
/// including fetching the existing data, validating the new data, and
/// checking for scheduling conflicts.
class EditUserItineraries {
  final ItineraryRepository repository;
  final ItineraryValidators validators;

  EditUserItineraries(this.repository, this.validators);

  /// Executes the use case to edit an itinerary.
  ///
  /// This method performs several validation checks before attempting to edit
  /// the itinerary. If any validation fails, it returns a [Failure].
  /// Otherwise, it calls the repository to edit the itinerary and returns
  /// a [Unit] on success.
  ///
  /// [itineraryInput] The itinerary data to be edited. Only non-null fields
  /// will be updated.
  Future<Either<Failure, Unit>> execute(EditItinerary itineraryInput) async {
    try {
      final existingItineraryResult = await repository.getItineraryById(
        itineraryInput.id,
      );

      if (existingItineraryResult.isLeft()) {
        return Left(ServerFailure('Itinerary not found'));
      }

      final existingItinerary = existingItineraryResult.fold(
        (failure) => throw Exception('Itinerary not found'),
        (itinerary) => itinerary,
      );

      final userIdResult = await repository.getUserIdByItineraryId(
        itineraryInput.id,
      );

      if (userIdResult.isLeft()) {
        return Left(ServerFailure('User itinerary association not found'));
      }

      final userId = userIdResult.fold(
        (failure) => throw Exception('User ID not found'),
        (id) => id,
      );

      final finalName = itineraryInput.name ?? existingItinerary.name;
      final finalNotes = itineraryInput.notes ?? existingItinerary.notes;
      final finalStartTime =
          itineraryInput.startTime ?? existingItinerary.startTime;
      final finalEndTime = itineraryInput.endTime ?? existingItinerary.endTime;

      final fieldLengthValidation = validators.validateFieldLengths(
        name: finalName,
        notes: finalNotes,
      );
      if (fieldLengthValidation.isLeft()) {
        return fieldLengthValidation;
      }

      if (itineraryInput.tourismSpot != null) {
        final tourismSpotValidation = await validators
            .validateTourismSpotExists(itineraryInput.tourismSpot);
        if (tourismSpotValidation.isLeft()) {
          return tourismSpotValidation;
        }
      }

      if (itineraryInput.startTime != null || itineraryInput.endTime != null) {
        if (itineraryInput.startTime != null) {
          final futureTimeValidation = validators.validateFutureTime(
            finalStartTime,
          );
          if (futureTimeValidation.isLeft()) {
            return futureTimeValidation;
          }
        }

        final timeRangeValidation = validators.validateTimeRange(
          finalStartTime,
          finalEndTime,
        );
        if (timeRangeValidation.isLeft()) {
          return timeRangeValidation;
        }

        final conflictCheck = await validators.checkSchedulingConflicts(
          userId,
          finalStartTime,
          finalEndTime,
          itineraryInput.id,
        );
        if (conflictCheck.isLeft()) {
          return conflictCheck;
        }
      }

      return await repository.editItinerary(itineraryInput);
    } catch (e) {
      developer.log(e.toString(), name: "Edit User Itineraries");
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
