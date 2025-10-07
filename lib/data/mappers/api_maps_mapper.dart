import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';
import 'package:lokapandu/domain/entities/maps_route_entity.dart';

extension ApiMapsMapper on MapsRoutesModel {
  MapsRoutes toDomain() => MapsRoutes(
    routes: routes
        .map(
          (e) =>
              MapsRoute(distanceMeters: e.distanceMeters, duration: e.duration),
        )
        .toList(),
  );
}
