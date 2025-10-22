import 'package:dartz/dartz.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class SearchTourismSpots {
  final TourismSpotRepository repository;

  SearchTourismSpots(this.repository);

  Future<Either<Failure, List<TourismSpot>>> execute(String query) async {
    return await repository.searchTourismSpots(query);
  }
}
