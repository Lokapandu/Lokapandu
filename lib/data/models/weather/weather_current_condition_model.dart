import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_current_condition_model.freezed.dart';
part 'weather_current_condition_model.g.dart';

@freezed
abstract class WeatherCurrentConditionModel
    with _$WeatherCurrentConditionModel {
  const factory WeatherCurrentConditionModel({
    required String text,
    required String icon,
    required int code,
  }) = _WeatherCurrentConditionModel;

  factory WeatherCurrentConditionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCurrentConditionModelFromJson(json);
}
