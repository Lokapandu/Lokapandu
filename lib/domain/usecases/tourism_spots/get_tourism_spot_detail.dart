import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class GetTourismSpotDetail {
  final TourismSpotRepository repository;

  GetTourismSpotDetail(this.repository);

  Future<Either<Failure, TourismSpot>> execute(int id) async {
    return await repository.getTourismSpotById(id);
  }
}
