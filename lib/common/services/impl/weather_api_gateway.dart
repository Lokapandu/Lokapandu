import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/services/weather_api_port.dart';
import 'package:lokapandu/data/models/weather/weather_model.dart';
import 'package:lokapandu/env/env.dart';

class WeatherApiGateway implements WeatherPort {
  final http.Client client;

  WeatherApiGateway({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String latLon) async {
    Uri uri = Uri.https(Env.weatherBaseUrl, 'v1/current.json', {
      'key': Env.weatherApiKey,
      'q': latLon,
      'aqi': 'no',
    });

    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        dev.log("Request input: $latLon", name: "WeatherRemoteDataSourceImpl");
        dev.log(
          'Response body: ${response.body}',
          name: 'WeatherRemoteDataSourceImpl',
        );
        final data = WeatherModel.fromJson(json.decode(response.body));
        return data;
      } else {
        throw Exception('Failed to load weather data');
      }
    } on FormatException catch (e, st) {
      throw DataParsingException(e.message, stackTrace: st);
    } on http.ClientException {
      throw ConnectionException('Failed to connect to the server');
    } catch (e, st) {
      throw ServerException('Failed to load weather data: $e', stacktrace: st);
    }
  }
}
