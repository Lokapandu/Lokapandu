import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class GetTourismSpotList {
  final TourismSpotRepository repository;

  GetTourismSpotList(this.repository);

  Future<Either<Failure, List<TourismSpot>>> execute() async {
    return await repository.getTourismSpots();
  }
}
