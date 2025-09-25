import 'package:lokapandu/brick/models/tourism_spot.model.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';

extension TourismSpotEntityMapper on TourismSpotEntity {
  TourismSpot toModel() => TourismSpot(
        id: id,
        name: name,
        description: description,
        city: city,
        province: province,
        category: category,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openTime: openTime,
        closeTime: closeTime,
        mapsLink: mapsLink,
        facilities: facilities,
        createdAt: createdAt,
      );
}

extension TourismSpotModelMapper on TourismSpot {
  TourismSpotEntity toEntity({List<TourismImageEntity> images = const []}) => 
      TourismSpotEntity(
        id: id,
        name: name,
        description: description,
        city: city,
        province: province,
        category: category,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openTime: openTime,
        closeTime: closeTime,
        mapsLink: mapsLink,
        facilities: facilities,
        images: images,
        createdAt: createdAt,
      );
}

extension TourismSpotModelListMapper on List<TourismSpot> {
  List<TourismSpotEntity> toEntityList({
    Map<int, List<TourismImageEntity>> imagesMap = const {},
  }) => map((spot) => spot.toEntity(images: imagesMap[spot.id] ?? [])).toList();
}

extension TourismSpotEntityListMapper on List<TourismSpotEntity> {
  List<TourismSpot> toModelList() => 
      map((entity) => entity.toModel()).toList();
}