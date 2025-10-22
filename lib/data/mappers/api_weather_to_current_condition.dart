import 'package:lokapandu/data/models/weather/weather_model.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';

extension ApiWeatherToCurrentCondition on WeatherModel {
  Weather toCurrentConditionEntity() => Weather(
    city: location.name,
    region: location.region,
    country: location.country,
    lat: location.lat,
    lon: location.lon,
    tzId: location.tzId,
    lastUpdated: DateTime.parse(current.lastUpdated),
    fahrenheitTemperature: current.tempF,
    celciusTemperature: current.tempC,
    text: current.condition.text,
    icon: current.condition.icon,
  );
}
