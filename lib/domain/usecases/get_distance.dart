import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/services/routes_api_port.dart';
import 'package:lokapandu/common/utils/api_call_handler.dart';
import 'package:lokapandu/data/mappers/api_maps_mapper.dart';
import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';
import 'package:lokapandu/domain/entities/maps_route_entity.dart';

class GetDistance {
  final RoutesPort _gateway;

  GetDistance(this._gateway);

  Future<Either<Failure, MapsRoutes>> execute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    return await executeApiCall<MapsRoutesModel>(
      () => _gateway.calculateRoute(origin: origin, destination: destination),
    ).then((value) => value.map((e) => e.toDomain()));
  }
}
