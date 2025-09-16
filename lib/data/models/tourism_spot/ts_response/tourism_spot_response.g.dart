// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_spot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TourismSpotResponse _$TourismSpotResponseFromJson(Map<String, dynamic> json) =>
    _TourismSpotResponse(
      models: (json['models'] as List<dynamic>)
          .map((e) => TourismSpotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TourismSpotResponseToJson(
  _TourismSpotResponse instance,
) => <String, dynamic>{'models': instance.models};
