import 'package:dartz/dartz.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/utils/api_call_handler.dart';
import 'package:lokapandu/data/datasources/weather_services.dart';
import 'package:lokapandu/data/mappers/api_weather_to_current_condition.dart';
import 'package:lokapandu/data/models/weather/weather_model.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';

class GetCurrentWeather {
  final WeatherPort _gateway;

  GetCurrentWeather(this._gateway);

  Future<Either<Failure, Weather>> execute({required String latLon}) async {
    return await executeApiCall<WeatherModel>(
      () => _gateway.getCurrentWeather(latLon),
    ).then((value) => value.map((e) => e.toCurrentConditionEntity()));
  }
}
