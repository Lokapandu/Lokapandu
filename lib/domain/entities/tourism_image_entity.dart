import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
part 'tourism_image_entity.freezed.dart';

@freezed
abstract class TourismImage with _$TourismImage {
  const factory TourismImage({
    required int id,
    required TourismSpot tourismSpot,
    required String label,
    required String imageUrl,
    required DateTime createdAt,
  }) = _TourismImage;
}
