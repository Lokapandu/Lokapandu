import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/repositories/tourism_spot_repository.dart';

class GetTourismSpotsByCategory {
  final TourismSpotRepository repository;

  GetTourismSpotsByCategory(this.repository);

  Future<Either<Failure, List<TourismSpot>>> execute(String category) async {
    return await repository.getTourismSpotsByCategory(category);
  }
}
