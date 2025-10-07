// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_current_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherCurrentConditionModel _$WeatherCurrentConditionModelFromJson(
  Map<String, dynamic> json,
) => _WeatherCurrentConditionModel(
  text: json['text'] as String,
  icon: json['icon'] as String,
  code: (json['code'] as num).toInt(),
);

Map<String, dynamic> _$WeatherCurrentConditionModelToJson(
  _WeatherCurrentConditionModel instance,
) => <String, dynamic>{
  'text': instance.text,
  'icon': instance.icon,
  'code': instance.code,
};
