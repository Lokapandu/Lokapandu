// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/data/models/weather/weather_current_condition_model.dart';

part 'weather_current_model.freezed.dart';
part 'weather_current_model.g.dart';

@freezed
abstract class WeatherCurrentModel with _$WeatherCurrentModel {
  @JsonSerializable(explicitToJson: true)
  const factory WeatherCurrentModel({
    @JsonKey(name: "last_updated_epoch") required int lastUpdatedEpoch,
    @JsonKey(name: "last_updated") required String lastUpdated,
    @JsonKey(name: "temp_c") required double tempC,
    @JsonKey(name: "temp_f") required double tempF,
    @JsonKey(name: "is_day") required int isDay,
    @JsonKey(name: "condition") required WeatherCurrentConditionModel condition,
    @JsonKey(name: "wind_mph") required double windMph,
    @JsonKey(name: "wind_kph") required double windKph,
    @JsonKey(name: "wind_degree") required int windDegree,
    @JsonKey(name: "wind_dir") required String windDir,
    @JsonKey(name: "pressure_mb") required int pressureMb,
    @JsonKey(name: "pressure_in") required double pressureIn,
    @JsonKey(name: "precip_mm") required int precipMm,
    @JsonKey(name: "precip_in") required int precipIn,
    @JsonKey(name: "humidity") required int humidity,
    @JsonKey(name: "cloud") required int cloud,
    @JsonKey(name: "feelslike_c") required double feelslikeC,
    @JsonKey(name: "feelslike_f") required double feelslikeF,
    @JsonKey(name: "windchill_c") required double windchillC,
    @JsonKey(name: "windchill_f") required double windchillF,
    @JsonKey(name: "heatindex_c") required double heatindexC,
    @JsonKey(name: "heatindex_f") required double heatindexF,
    @JsonKey(name: "dewpoint_c") required double dewpointC,
    @JsonKey(name: "dewpoint_f") required double dewpointF,
    @JsonKey(name: "vis_km") required int visKm,
    @JsonKey(name: "vis_miles") required int visMiles,
    @JsonKey(name: "uv") required double uv,
    @JsonKey(name: "gust_mph") required double gustMph,
    @JsonKey(name: "gust_kph") required double gustKph,
    @JsonKey(name: "short_rad") required int shortRad,
    @JsonKey(name: "diff_rad") required int diffRad,
    @JsonKey(name: "dni") required int dni,
    @JsonKey(name: "gti") required int gti,
  }) = _WeatherCurrentModel;

  factory WeatherCurrentModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCurrentModelFromJson(json);
}
