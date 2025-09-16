import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lokapandu/domain/entities/tourism_image.dart';
part 'tourism_image_model.freezed.dart';
part 'tourism_image_model.g.dart';

@freezed
abstract class TourismImageModel with _$TourismImageModel {
  const factory TourismImageModel({
    required String id,
    required String label,
    required String fileName,
  }) = _TourismImageModel;

  factory TourismImageModel.fromJson(Map<String, dynamic> json) =>
      _$TourismImageModelFromJson(json);
}

extension TourismImageModelX on TourismImageModel {
  TourismImage toEntity() =>
      TourismImage(id: id, label: label, fileName: fileName);
}
