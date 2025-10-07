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
    String body = json.encode({
      'origin': {
        'location': {
          'latLng': {
            'latitude': origin.latitude.toString(),
            'longitude': origin.longitude.toString(),
          },
        },
      },
      'destination': {
        'location': {
          'latLng': {
            'latitude': destination.latitude.toString(),
            'longitude': destination.longitude.toString(),
          },
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
    });

    try {
      final response = await client.post(
        uri,
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': 'AIzaSyAAE7COwXgnymoY5osw_oaq1leh0FNSRbI',
          'X-Goog-FieldMask': 'routes.duration,routes.distanceMeters',
        },
      );
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map && decoded.isEmpty) {
          return MapsRoutesModel(routes: []);
        }
        return MapsRoutesModel.fromJson(decoded);
      } else {
        throw ServerException(
          'HTTP:${response.statusCode}: ${json.decode(response.body)['error']['message']}',
        );
      }
    } on FormatException catch (e) {
      throw DataParsingException(e.message);
    } on http.ClientException {
      throw ConnectionException('Failed to connect to the server');
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
