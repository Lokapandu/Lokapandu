// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_spot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TourismSpotModel _$TourismSpotModelFromJson(Map<String, dynamic> json) =>
    _TourismSpotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      openTime: json['openTime'] as String,
      closeTime: json['closeTime'] as String,
      googleMapsLink: json['googleMapsLink'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => TourismImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => FacilitiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TourismSpotModelToJson(_TourismSpotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'province': instance.province,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'googleMapsLink': instance.googleMapsLink,
      'images': instance.images,
      'facilities': instance.facilities,
    };
