import 'package:lokapandu/data/models/weather/weather_model.dart';

abstract class WeatherPort {
  Future<WeatherModel> getCurrentWeather(String city);
}
