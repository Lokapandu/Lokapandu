// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tourism_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TourismImageModel _$TourismImageModelFromJson(Map<String, dynamic> json) =>
    _TourismImageModel(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      tourismSpotId: (json['tourism_spot_id'] as num).toInt(),
    );

Map<String, dynamic> _$TourismImageModelToJson(_TourismImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'tourism_spot_id': instance.tourismSpotId,
    };
