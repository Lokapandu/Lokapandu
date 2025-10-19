import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary/itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

/// Use case for getting all itineraries for a specific user.
///
/// This class handles the business logic for fetching the itineraries.
class GetUserItineraries {
  final ItineraryRepository repository;

  GetUserItineraries(this.repository);

  /// Executes the use case to get all itineraries for a user.
  ///
  /// This method calls the repository to get the itineraries for the given user ID.
  /// It returns a list of [Itinerary] on success or a [Failure] if an error occurs.
  ///
  /// [userId] The ID of the user whose itineraries are to be fetched.
  Future<Either<Failure, List<Itinerary>>> execute(String userId) async {
    return await repository.getUserItineraries(userId);
  }
}
