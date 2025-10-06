// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maps_routes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapsRoutesModel _$MapsRoutesModelFromJson(Map<String, dynamic> json) =>
    _MapsRoutesModel(
      routes: (json['routes'] as List<dynamic>)
          .map((e) => MapsRouteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapsRoutesModelToJson(_MapsRoutesModel instance) =>
    <String, dynamic>{'routes': instance.routes};

_MapsRouteModel _$MapsRouteModelFromJson(Map<String, dynamic> json) =>
    _MapsRouteModel(
      distanceMeters: (json['distanceMeters'] as num).toInt(),
      duration: json['duration'] as String,
    );

Map<String, dynamic> _$MapsRouteModelToJson(_MapsRouteModel instance) =>
    <String, dynamic>{
      'distanceMeters': instance.distanceMeters,
      'duration': instance.duration,
    };
