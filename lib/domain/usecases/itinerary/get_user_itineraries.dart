import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary_entity.dart';
import 'package:lokapandu/domain/repositories/itinerary_repository.dart';

class GetUserItineraries {
  final ItineraryRepository repository;

  GetUserItineraries(this.repository);

  Future<Either<Failure, List<Itinerary>>> execute(String userId) async {
    return await repository.getUserItineraries(userId);
  }
}