import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/edit_itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class EditUserItineraries {
  final ItineraryRepository repository;

  EditUserItineraries(this.repository);

  Future<Either<Failure, Unit>> execute(EditItinerary newItinerary) async {
    return await repository.editItinerary(newItinerary);
  }
}