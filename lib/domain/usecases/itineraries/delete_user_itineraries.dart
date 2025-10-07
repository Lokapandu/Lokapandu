import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class DeleteUserItineraries {
  final ItineraryRepository repository;

  DeleteUserItineraries(this.repository);

  Future<Either<Failure, Unit>> execute(String itineraryId) async {
    return await repository.deleteItinerary(itineraryId);
  }
}