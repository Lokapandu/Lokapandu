import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

abstract class TourismSpotRepository {
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots();
  Future<Either<Failure, TourismSpot>> getTourismSpotById(int id);
}
