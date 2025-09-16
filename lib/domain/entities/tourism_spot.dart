import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/facilities.dart';
import 'package:lokapandu/domain/entities/tourism_image.dart';

part 'tourism_spot.freezed.dart';

@freezed
abstract class TourismSpot with _$TourismSpot {
  const factory TourismSpot({
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
    required List<TourismImage> images,
    required List<Facilities> facilities,
  }) = _TourismSpot;
}
