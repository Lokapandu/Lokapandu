import 'package:freezed_annotation/freezed_annotation.dart';
part 'tourism_image.freezed.dart';

@freezed
abstract class TourismImage with _$TourismImage {
  const factory TourismImage({
    required String id,
    required String label,
    required String fileName,
  }) = _TourismImage;
}
