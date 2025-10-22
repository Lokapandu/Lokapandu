import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';

abstract class ItineraryRepository {
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(
    String userId, {
    String? filterByDate,
  });

  Future<Either<Failure, Unit>> createItinerary(CreateItinerary itineraryInput);

  Future<Either<Failure, Unit>> createItineraryNote(
    CreateItineraryNote itineraryNoteInput,
  );

  Future<Either<Failure, Unit>> editItinerary(EditItinerary itineraryInput);

  Future<Either<Failure, Unit>> deleteItinerary(String itineraryId);

  Future<Either<Failure, Itinerary>> getItineraryById(String itineraryId);

  Future<Either<Failure, String>> getUserIdByItineraryId(String itineraryId);

  Future<Either<Failure, bool>> checkTourismSpotExists(int tourismSpotId);

  Future<Either<Failure, bool>> checkSchedulingConflicts(
    String userId,
    DateTime startTime,
    DateTime endTime, [
    String? excludeItineraryId,
  ]);
}
