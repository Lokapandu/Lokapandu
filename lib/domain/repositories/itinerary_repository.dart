import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';

abstract class ItineraryRepository {
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(String userId);
  Future<Either<Failure, Unit>> createItinerary(String userId, CreateItinerary itineraryInput);
  Future<Either<Failure, Unit>> createItineraryNote(String userId, CreateItineraryNote itineraryNoteInput);
}