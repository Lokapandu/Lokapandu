import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';
import 'package:lokapandu/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository _repository;

  GetCurrentWeather(this._repository);

  Future<Either<Failure, Weather>> execute({required String latLon}) async {
    return await _repository.getCurrentWeather(latLon: latLon);
  }
}
