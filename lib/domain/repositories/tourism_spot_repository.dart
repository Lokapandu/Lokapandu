import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

abstract class TourismSpotRepository {
  Future<Either<Failure, List<TourismSpot>>> getTourismSpots({
    String? query,
    String? category,
    int page = 1,
    int perPage = 10,
  });

  Future<Either<Failure, TourismSpot>> getTourismSpotById(int id);
}
