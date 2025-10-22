import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

abstract class TourismSpotRepository {
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots(String? query);
  Future<Either<Failure, TourismSpot>> getTourismSpotById(int id);
  Future<Either<Failure, List<TourismSpot>>> searchTourismSpots(String query);
  Future<Either<Failure, List<TourismSpot>>> getTourismSpotsByCategory(
    String category,
  );
}
