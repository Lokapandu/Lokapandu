import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL')
  static const String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_KEY')
  static const String supabaseKey = _Env.supabaseKey;

  @EnviedField(varName: 'WEATHER_API_KEY')
  static const String weatherApiKey = _Env.weatherApiKey;

  @EnviedField(varName: 'WEATHER_BASE')
  static const String weatherBaseUrl = _Env.weatherBaseUrl;

  @EnviedField(varName: 'MAPS_API_KEY')
  static const String mapsApiKey = _Env.mapsApiKey;

  @EnviedField(varName: 'GOOGLE_ROUTES_API_URL')
  static const String googleRoutesApiUrl = _Env.googleRoutesApiUrl;
}
