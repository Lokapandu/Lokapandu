// MAPPER FOR TOURISM SPOT ENTITY AND MODEL FROM BRICK'S MODEL
import 'package:lokapandu/brick/models/tourism_spot.model.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';

extension TourismSpotEntityMapper on TourismSpot {
  TourismSpotModel toBrickModel() => TourismSpotModel(
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

extension TourismSpotModelMapper on TourismSpotModel {
  TourismSpot toEntity({List<TourismImage> images = const []}) => TourismSpot(
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

extension TourismSpotModelListMapper on List<TourismSpotModel> {
  List<TourismSpot> toEntityList({
    Map<int, List<TourismImage>> imagesMap = const {},
  }) => map((spot) => spot.toEntity(images: imagesMap[spot.id] ?? [])).toList();
}

extension TourismSpotEntityListMapper on List<TourismSpot> {
  List<TourismSpotModel> toModelList() =>
      map((entity) => entity.toBrickModel()).toList();
}
