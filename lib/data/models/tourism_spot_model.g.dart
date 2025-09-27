// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_spot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TourismSpotModel _$TourismSpotModelFromJson(Map<String, dynamic> json) =>
    _TourismSpotModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      city: json['city'] as String,
      province: json['province'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
      mapsLink: json['maps_link'] as String?,
      facilities: json['facilities'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      category: json['category'] as String?,
      embedding: json['embedding'] as String?,
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
      'open_time': instance.openTime,
      'close_time': instance.closeTime,
      'maps_link': instance.mapsLink,
      'facilities': instance.facilities,
      'created_at': instance.createdAt.toIso8601String(),
      'category': instance.category,
      'embedding': instance.embedding,
    };
