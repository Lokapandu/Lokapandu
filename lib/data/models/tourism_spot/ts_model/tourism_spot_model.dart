import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/data/models/facilities/facilities_model.dart';
import 'package:lokapandu/data/models/tourism_image/tourism_image_model.dart';
import 'package:lokapandu/domain/entities/tourism_spot.dart';
part 'tourism_spot_model.freezed.dart';
part 'tourism_spot_model.g.dart';

@freezed
abstract class TourismSpotModel with _$TourismSpotModel {
  const factory TourismSpotModel({
    required String id,
    required String name,
    required String description,
    required String city,
    required String province,
    required String address,
    required double latitude,
    required double longitude,
    required String openTime,
    required String closeTime,
    required String googleMapsLink,
    required List<TourismImageModel> images,
    required List<FacilitiesModel> facilities,
  }) = _TourismSpotModel;

  factory TourismSpotModel.fromJson(Map<String, dynamic> json) =>
      _$TourismSpotModelFromJson(json);
}

extension TourismSpotModelX on TourismSpotModel {
  TourismSpot toEntity() => TourismSpot(
    id: id,
    name: name,
    description: description,
    city: city,
    province: province,
    address: address,
    latitude: latitude,
    longitude: longitude,
    openTime: openTime,
    closeTime: closeTime,
    googleMapsLink: googleMapsLink,
    images: images.map((e) => e.toEntity()).toList(),
    facilities: facilities.map((e) => e.toEntity()).toList(),
  );
}
