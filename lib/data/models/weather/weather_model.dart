import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:lokapandu/data/models/weather/weather_current_model.dart';
import 'package:lokapandu/data/models/weather/weather_location_model.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required WeatherLocationModel location,
    required WeatherCurrentModel current,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}
