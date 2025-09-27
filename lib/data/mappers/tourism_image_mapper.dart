// MAPPER FOR TOURISM IMAGE ENTITY AND MODEL FROM BRICK'S MODEL
import 'package:lokapandu/brick/models/tourism_image.model.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'tourism_spot_mapper.dart';

extension TourismImageEntityMapper on TourismImage {
  TourismImageModel toModel() => TourismImageModel(
    id: id,
    tourismSpot: tourismSpot.toModel(),
    imageUrl: imageUrl,
    label: label,
    createdAt: createdAt,
  );
}

extension TourismImageModelMapper on TourismImageModel {
  TourismImage toEntity() => TourismImage(
    id: id,
    tourismSpot: tourismSpot.toEntity(),
    imageUrl: imageUrl,
    label: label,
    createdAt: createdAt,
  );
}

extension TourismImageModelListMapper on List<TourismImageModel> {
  List<TourismImage> toEntityList() =>
      map((image) => image.toEntity()).toList();
}

extension TourismImageEntityListMapper on List<TourismImage> {
  List<TourismImageModel> toModelList() =>
      map((entity) => entity.toModel()).toList();
}
