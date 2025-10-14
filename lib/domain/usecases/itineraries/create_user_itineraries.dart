import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';

/// Use case for creating a new user itinerary.
///
/// This class handles the business logic for creating a new itinerary,
/// including validation of the input data.
class CreateUserItineraries {
  final ItineraryRepository repository;
  final ItineraryValidators validators;

  CreateUserItineraries(this.repository, this.validators);

  /// Executes the use case to create a new itinerary.
  ///
  /// This method performs several validation checks before attempting to create
  /// the itinerary. If any validation fails, it returns a [Failure].
  /// Otherwise, it calls the repository to create the itinerary and returns
  /// a [Unit] on success.
  ///
  /// [userId] The ID of the user creating the itinerary.
  /// [itineraryInput] The itinerary data to be created.
  Future<Either<Failure, Unit>> execute(
    String userId,
    CreateItinerary itineraryInput,
  ) async {
    final requiredFieldsValidation = validators.validateRequiredFields(
      itineraryInput,
    );
    if (requiredFieldsValidation.isLeft()) {
      return requiredFieldsValidation;
    }

    final fieldLengthValidation = validators.validateFieldLengths(
      name: itineraryInput.name,
      notes: itineraryInput.notes,
    );
    if (fieldLengthValidation.isLeft()) {
      return fieldLengthValidation;
    }

    final futureTimeValidation = validators.validateFutureTime(
      itineraryInput.startTime,
    );
    if (futureTimeValidation.isLeft()) {
      return futureTimeValidation;
    }

    final timeRangeValidation = validators.validateTimeRange(
      itineraryInput.startTime,
      itineraryInput.endTime,
    );
    if (timeRangeValidation.isLeft()) {
      return timeRangeValidation;
    }

    final tourismSpotValidation = await validators.validateTourismSpotExists(
      itineraryInput.tourismSpot,
    );
    if (tourismSpotValidation.isLeft()) {
      return tourismSpotValidation;
    }

    final conflictCheck = await validators.checkSchedulingConflicts(
      userId,
      itineraryInput.startTime,
      itineraryInput.endTime,
    );
    if (conflictCheck.isLeft()) {
      return conflictCheck;
    }

    return await repository.createItinerary(userId, itineraryInput);
  }
}
