// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tourism_spot_model.freezed.dart';
part 'tourism_spot_model.g.dart';

@freezed
abstract class TourismSpotModel with _$TourismSpotModel {
  const factory TourismSpotModel({
    required int id,
    required String name,
    @JsonKey(name: 'description') String? description,
    required String city,
    required String province,
    required String address,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'open_time') required String openTime,
    @JsonKey(name: 'close_time') required String closeTime,
    @JsonKey(name: 'maps_link') String? mapsLink,
    String? facilities,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    String? category,
    String? embedding,
  }) = _TourismSpotModel;

  factory TourismSpotModel.fromJson(Map<String, dynamic> json) =>
      _$TourismSpotModelFromJson(json);
}
