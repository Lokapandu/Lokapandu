import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class GetTourismSpotList {
  final TourismSpotRepository repository;

  GetTourismSpotList(this.repository);

  Future<Either<Failure, List<TourismSpot>>> execute({
    String? query,
    String? category,
    int page = 1,
    int perPage = 10,
  }) async {
    return await repository.getTourismSpots(page: page, perPage: perPage);
  }
}
