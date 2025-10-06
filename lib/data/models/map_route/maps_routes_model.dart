import 'package:freezed_annotation/freezed_annotation.dart';

part 'maps_routes_model.freezed.dart';
part 'maps_routes_model.g.dart';

@freezed
abstract class MapsRoutesModel with _$MapsRoutesModel {
  const factory MapsRoutesModel({required List<MapsRouteModel> routes}) =
      _MapsRoutesModel;

  factory MapsRoutesModel.fromJson(Map<String, dynamic> json) =>
      _$MapsRoutesModelFromJson(json);
}

@freezed
abstract class MapsRouteModel with _$MapsRouteModel {
  const factory MapsRouteModel({
    required int distanceMeters,
    required String duration,
    required MapsRoutePolyline polyline,
  }) = _MapsRouteModel;

  factory MapsRouteModel.fromJson(Map<String, dynamic> json) =>
      _$MapsRouteModelFromJson(json);
}

@freezed
abstract class MapsRoutePolyline with _$MapsRoutePolyline {
  const factory MapsRoutePolyline({required String encodedPolyline}) = _MapsRoutePolyline;

  factory MapsRoutePolyline.fromJson(Map<String, dynamic> json) =>
      _$MapsRoutePolylineFromJson(json);
}
