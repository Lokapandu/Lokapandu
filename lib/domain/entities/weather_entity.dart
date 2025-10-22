import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_entity.freezed.dart';

@freezed
abstract class Weather with _$Weather {
  const factory Weather({
    required String city,
    required String region,
    required String country,
    required double lat,
    required double lon,
    required String tzId,
    required DateTime lastUpdated,
    required double fahrenheitTemperature,
    required double celciusTemperature,
    required String text,
    required String icon,
  }) = _Weather;
}
