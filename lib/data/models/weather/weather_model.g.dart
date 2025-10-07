// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) =>
    _WeatherModel(
      location: WeatherLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      current: WeatherCurrentModel.fromJson(
        json['current'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WeatherModelToJson(_WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };
