import 'package:freezed_annotation/freezed_annotation.dart';

part 'tourism_image_entity.freezed.dart';

@freezed
abstract class TourismImage with _$TourismImage {
  const factory TourismImage({
    required int id,
    required int tourismSpotId,
    required String label,
    required String imageUrl,
    required DateTime createdAt,
  }) = _TourismImage;
}
