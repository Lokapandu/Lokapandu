// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tourism_image_model.freezed.dart';
part 'tourism_image_model.g.dart';

@freezed
abstract class TourismImageModel with _$TourismImageModel {
  const factory TourismImageModel({
    required int id,
    required String label,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'tourism_spot_id') required int tourismSpotId,
  }) = _TourismImageModel;

  factory TourismImageModel.fromJson(Map<String, dynamic> json) =>
      _$TourismImageModelFromJson(json);
}
