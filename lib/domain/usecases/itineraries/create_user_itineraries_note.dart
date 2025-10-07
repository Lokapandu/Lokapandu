import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_note_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class CreateUserItinerariesNote {
  final ItineraryRepository repository;

  CreateUserItinerariesNote(this.repository);

  Future<Either<Failure, Unit>> execute(String userId, CreateItineraryNote itineraryInput) async {
    return await repository.createItineraryNote(userId, itineraryInput);
  }
}