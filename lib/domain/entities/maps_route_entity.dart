import 'package:freezed_annotation/freezed_annotation.dart';
part 'maps_route_entity.freezed.dart';

@freezed
abstract class MapsRoute with _$MapsRoute {
  const factory MapsRoute({
    required int distanceMeters,
    required String duration,
  }) = _MapsRoute;
}