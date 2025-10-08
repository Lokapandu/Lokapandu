import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';

class CreateUserItineraries {
  final ItineraryRepository repository;

  CreateUserItineraries(this.repository);

  Future<Either<Failure, Unit>> execute(
    String userId,
    CreateItinerary itineraryInput,
  ) async {
    final requiredFieldsValidation = ItineraryValidators.validateRequiredFields(
      itineraryInput,
    );
    if (requiredFieldsValidation.isLeft()) {
      return requiredFieldsValidation;
    }

    final fieldLengthValidation = ItineraryValidators.validateFieldLengths(
      name: itineraryInput.name,
      notes: itineraryInput.notes,
    );
    if (fieldLengthValidation.isLeft()) {
      return fieldLengthValidation;
    }

    final futureTimeValidation = ItineraryValidators.validateFutureTime(
      itineraryInput.startTime,
    );
    if (futureTimeValidation.isLeft()) {
      return futureTimeValidation;
    }

    final timeRangeValidation = ItineraryValidators.validateTimeRange(
      itineraryInput.startTime,
      itineraryInput.endTime,
    );
    if (timeRangeValidation.isLeft()) {
      return timeRangeValidation;
    }

    final tourismSpotValidation =
        await ItineraryValidators.validateTourismSpotExists(
          itineraryInput.tourismSpot,
        );
    if (tourismSpotValidation.isLeft()) {
      return tourismSpotValidation;
    }

    final conflictCheck = await ItineraryValidators.checkSchedulingConflicts(
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
