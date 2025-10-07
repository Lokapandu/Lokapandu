import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';

abstract class RoutesPort {
  Future<MapsRoutesModel> calculateRoute({
    required LatLng origin,
    required LatLng destination,
  });
}
