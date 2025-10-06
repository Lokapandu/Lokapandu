import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/itinerary_entity.dart';

abstract class ItineraryRepository {
  Future<Either<Failure, List<Itinerary>>> getUserItineraries(String id);
}