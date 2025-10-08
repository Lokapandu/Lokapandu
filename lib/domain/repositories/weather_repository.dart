import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather({required String latLon});
}