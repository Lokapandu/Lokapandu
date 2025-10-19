import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

/// Use case for deleting a user itinerary.
///
/// This class handles the business logic for deleting an itinerary.
class DeleteUserItineraries {
  final ItineraryRepository repository;

  DeleteUserItineraries(this.repository);

  /// Executes the use case to delete an itinerary.
  ///
  /// This method calls the repository to delete the itinerary with the given ID.
  /// It returns a [Unit] on success or a [Failure] if an error occurs.
  ///
  /// [itineraryId] The ID of the itinerary to be deleted.
  Future<Either<Failure, Unit>> execute(String itineraryId) async {
    return await repository.deleteItinerary(itineraryId);
  }
}
