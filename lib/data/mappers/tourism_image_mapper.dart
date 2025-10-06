// MAPPER FOR TOURISM IMAGE ENTITY AND MODEL FROM BRICK'S MODEL
import 'package:lokapandu/brick/models/tourism_image.model.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';


extension TourismImageEntityMapper on TourismImage {
  TourismImageModel toBrickModel() => TourismImageModel(
    id: id,
    tourismSpotId: tourismSpotId,
    imageUrl: imageUrl,
    label: label,
    createdAt: createdAt,
  );
}

extension TourismImageModelMapper on TourismImageModel {
  TourismImage toEntity() => TourismImage(
    id: id,
    tourismSpotId: tourismSpotId,
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
      map((entity) => entity.toBrickModel()).toList();
}
