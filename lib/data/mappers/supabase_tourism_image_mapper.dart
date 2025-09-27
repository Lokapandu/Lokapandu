import 'package:lokapandu/data/models/tourism_image_model.dart';
import 'package:lokapandu/domain/entities/tourism_image_entity.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';

// Extension to convert TourismImageModel (data layer) to TourismImage (domain layer)
extension SupabaseTourismImageModelMapper on TourismImageModel {
  TourismImage toEntity(TourismSpot tourismSpot) => TourismImage(
    id: id,
    tourismSpot: tourismSpot,
    label: label,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );
}

// Extension to convert TourismImage (domain layer) to TourismImageModel (data layer)
extension SupabaseTourismImageEntityMapper on TourismImage {
  TourismImageModel toModel() => TourismImageModel(
    id: id,
    label: label,
    imageUrl: imageUrl,
    createdAt: createdAt,
    tourismSpotId: tourismSpot.id,
  );
}

// Extension to convert list of TourismImageModel to list of TourismImage entities
extension SupabaseTourismImageModelListMapper on List<TourismImageModel> {
  List<TourismImage> toEntityList(Map<int, TourismSpot> spotsMap) =>
      map((image) {
        final spot = spotsMap[image.tourismSpotId];
        if (spot == null) {
          throw Exception('Tourism spot not found for image ${image.id}');
        }
        return image.toEntity(spot);
      }).toList();
}
