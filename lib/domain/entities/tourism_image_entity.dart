import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
part 'tourism_image_entity.freezed.dart';

@freezed
abstract class TourismImageEntity with _$TourismImageEntity {
  const factory TourismImageEntity({
    required int id,
    required TourismSpotEntity tourismSpot,
    required String label,
    required String imageUrl,
    required DateTime createdAt,
  }) = _TourismImageEntity;
}
