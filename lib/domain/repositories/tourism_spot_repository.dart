import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

abstract class TourismSpotRepository {
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots();
}
