import 'package:lokapandu/brick/models/tourism_image.model.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'tourism_spot_mapper.dart';

extension TourismImageEntityMapper on TourismImageEntity {
  TourismImage toModel() => TourismImage(
        id: id,
        tourismSpot: tourismSpot.toModel(),
        imageUrl: imageUrl,
        label: label,
        createdAt: createdAt,
      );
}

extension TourismImageModelMapper on TourismImage {
  TourismImageEntity toEntity() => TourismImageEntity(
        id: id,
        tourismSpot: tourismSpot.toEntity(),
        imageUrl: imageUrl,
        label: label,
        createdAt: createdAt,
      );
}

extension TourismImageModelListMapper on List<TourismImage> {
  List<TourismImageEntity> toEntityList() => 
      map((image) => image.toEntity()).toList();
}

extension TourismImageEntityListMapper on List<TourismImageEntity> {
  List<TourismImage> toModelList() => 
      map((entity) => entity.toModel()).toList();
}