import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

/// A use case for getting a user's itinerary by its ID.
///
/// This class encapsulates the business logic for retrieving a specific
/// itinerary from the repository.
class GetUserItineraryById {
  final ItineraryRepository repository;

  GetUserItineraryById(this.repository);

  /// Executes the use case to fetch an itinerary by its [itineraryId].
  ///
  /// Returns a [Future] that completes with an [Either] type.
  /// On success, it returns a [Right] with an [Itinerary] object.
  /// On failure, it returns a [Left] with a [Failure] object.
  Future<Either<Failure, Itinerary>> execute(String itineraryId) async {
    return await repository.getItineraryById(itineraryId);
  }
}
