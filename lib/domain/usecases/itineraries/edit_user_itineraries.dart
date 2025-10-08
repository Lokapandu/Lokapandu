import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:lokapandu/brick/models/itinerary.model.dart';
import 'package:lokapandu/brick/models/user_itinerary.model.dart';
import 'package:lokapandu/brick/repositories/repository.dart';
import 'package:brick_offline_first/brick_offline_first.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';
import 'package:lokapandu/domain/validators/itinerary_validators.dart';

class EditUserItineraries {
  final ItineraryRepository repository;

  EditUserItineraries(this.repository);

  Future<Either<Failure, Unit>> execute(EditItinerary itineraryInput) async {
    try {
      final existingItineraryResults = await Repository()
          .getAll<ItineraryModel>(
            query: Query.where('id', itineraryInput.id),
            policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
          );

      if (existingItineraryResults == null ||
          existingItineraryResults.isEmpty) {
        return Left(ServerFailure('Itinerary not found'));
      }

      final existingItinerary = existingItineraryResults.first;

      final userItineraryResults = await Repository()
          .getAll<UserItineraryModel>(
            query: Query.where('itinerariesId', itineraryInput.id),
            policy: OfflineFirstGetPolicy.awaitRemoteWhenNoneExist,
          );

      if (userItineraryResults == null || userItineraryResults.isEmpty) {
        return Left(ServerFailure('User itinerary association not found'));
      }

      final userId = userItineraryResults.first.userId;

      final finalName = itineraryInput.name ?? existingItinerary.name;
      final finalNotes = itineraryInput.notes ?? existingItinerary.notes;
      final finalStartTime =
          itineraryInput.startTime ?? existingItinerary.startTime;
      final finalEndTime = itineraryInput.endTime ?? existingItinerary.endTime;

      final fieldLengthValidation = ItineraryValidators.validateFieldLengths(
        name: finalName,
        notes: finalNotes,
      );
      if (fieldLengthValidation.isLeft()) {
        return fieldLengthValidation;
      }

      if (itineraryInput.tourismSpot != null) {
        final tourismSpotValidation =
            await ItineraryValidators.validateTourismSpotExists(
              itineraryInput.tourismSpot,
            );
        if (tourismSpotValidation.isLeft()) {
          return tourismSpotValidation;
        }
      }

      if (itineraryInput.startTime != null || itineraryInput.endTime != null) {
        if (itineraryInput.startTime != null) {
          final futureTimeValidation = ItineraryValidators.validateFutureTime(
            finalStartTime,
          );
          if (futureTimeValidation.isLeft()) {
            return futureTimeValidation;
          }
        }

        final timeRangeValidation = ItineraryValidators.validateTimeRange(
          finalStartTime,
          finalEndTime,
        );
        if (timeRangeValidation.isLeft()) {
          return timeRangeValidation;
        }

        final conflictCheck =
            await ItineraryValidators.checkSchedulingConflicts(
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
