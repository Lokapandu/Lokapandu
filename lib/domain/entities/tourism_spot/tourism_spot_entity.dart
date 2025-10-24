import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:lokapandu/domain/entities/tourism_spot/tourism_image_entity.dart';

part 'tourism_spot_entity.freezed.dart';

@freezed
abstract class TourismSpot with _$TourismSpot {
  const factory TourismSpot({
    required int id,
    required String name,
    required String description,
    required String category,
    required String city,
    required String province,
    required String address,
    required double latitude,
    required double longitude,
    required String openTime,
    required String closeTime,
    required String mapsLink,
    required List<TourismImage> images,
    required String facilities,
    required DateTime createdAt,
  }) = _TourismSpot;
}
