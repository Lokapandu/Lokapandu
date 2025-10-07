import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/create_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class CreateUserItineraries {
  final ItineraryRepository repository;

  CreateUserItineraries(this.repository);

  Future<Either<Failure, Unit>> execute(String userId, CreateItinerary itineraryInput) async {
    return await repository.createItinerary(userId, itineraryInput);
  }
}