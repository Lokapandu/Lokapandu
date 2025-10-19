import 'package:lokapandu/data/models/tourism_spot_model.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_image_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot/tourism_spot_entity.dart';

// Extension to convert TourismSpotModel (data layer) to TourismSpot (domain layer)
extension SupabaseTourismSpotModelMapper on TourismSpotModel {
  TourismSpot toEntity({List<TourismImage> images = const []}) => TourismSpot(
    id: id,
    name: name,
    description: description ?? '',
    category: category ?? '',
    city: city,
    province: province,
    address: address,
    latitude: latitude,
    longitude: longitude,
    openTime: openTime,
    closeTime: closeTime,
    mapsLink: mapsLink ?? '',
    facilities: facilities ?? '',
    images: images,
    createdAt: createdAt,
  );
}

// Extension to convert TourismSpot (domain layer) to TourismSpotModel (data layer)
extension SupabaseTourismSpotEntityMapper on TourismSpot {
  TourismSpotModel toModel() => TourismSpotModel(
    id: id,
    name: name,
    description: description.isEmpty ? null : description,
    category: category.isEmpty ? null : category,
    city: city,
    province: province,
    address: address,
    latitude: latitude,
    longitude: longitude,
    openTime: openTime,
    closeTime: closeTime,
    mapsLink: mapsLink.isEmpty ? null : mapsLink,
    facilities: facilities.isEmpty ? null : facilities,
    createdAt: createdAt,
  );
}

// Extension to convert list of TourismSpotModel to list of TourismSpot entities
extension SupabaseTourismSpotModelListMapper on List<TourismSpotModel> {
  List<TourismSpot> toEntityList({
    Map<int, List<TourismImage>> imagesMap = const {},
  }) => map((spot) => spot.toEntity(images: imagesMap[spot.id] ?? [])).toList();
}
