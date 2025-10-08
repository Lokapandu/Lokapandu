import 'package:lokapandu/data/models/weather/weather_model.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';

extension ApiWeatherToCurrentCondition on WeatherModel {
  Weather toCurrentConditionEntity() => Weather(
    fahrenheitTemperature: current.tempF,
    celciusTemperature: current.tempC,
    text: current.condition.text,
    icon: current.condition.icon,
  );
}
