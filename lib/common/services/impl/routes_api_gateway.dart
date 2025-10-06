import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/services/routes_api_port.dart';
import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';
import 'package:lokapandu/env/env.dart';

class RoutesApiGateway implements RoutesPort {
  final http.Client client;

  RoutesApiGateway({required this.client});

  @override
  Future<MapsRoutesModel> calculateRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    Uri uri = Uri.https(Env.googleRoutesApiUrl, 'directions/v2:computeRoutes');

    try {
      final response = await client.post(
        uri,
        body: {
          'origin': {
            'location': {
              'latitude': origin.latitude,
              'longitude': origin.longitude,
            },
          },
          'destination': {
            'location': {
              'latitude': destination.latitude,
              'longitude': destination.longitude,
            },
          },
          'travelMode': 'DRIVE',
          'routingPreference': "TRAFFIC_AWARE",
          'computeAlternativeRoutes': false,
          'routeModifiers': {
            'avoidTolls': false,
            'avoidHighways': false,
            'avoidFerries': false,
          },
          'languageCode': 'en-US',
          'units': 'METRIC',
        },
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': Env.mapsApiKey,
          'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters',
        },
      );

      if (response.statusCode == 200) {
        return MapsRoutesModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to load routes data: ${response.statusCode}',
        );
      }
    } on FormatException catch (e) {
      throw DataParsingException(e.message);
    } on http.ClientException {
      throw ConnectionException('Failed to connect to the server');
    } catch (e) {
      throw ServerException('Failed to load weather data: $e');
    }
  }
}
