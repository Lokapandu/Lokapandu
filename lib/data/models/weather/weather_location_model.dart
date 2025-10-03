// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_location_model.freezed.dart';
part 'weather_location_model.g.dart';

@freezed
abstract class WeatherLocationModel with _$WeatherLocationModel {
  @JsonSerializable(explicitToJson: true)
  factory WeatherLocationModel({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "region") required String region,
    @JsonKey(name: "country") required String country,
    @JsonKey(name: "lat") required double lat,
    @JsonKey(name: "lon") required double lon,
    @JsonKey(name: "tz_id") required String tzId,
    @JsonKey(name: "localtime_epoch") required int localtimeEpoch,
    @JsonKey(name: "localtime") required String localtime,
  }) = _WeatherLocationModel;

  factory WeatherLocationModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationModelFromJson(json);
}
