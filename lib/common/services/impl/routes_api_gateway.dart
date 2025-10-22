import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/services/routes_api_port.dart';
import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';

class RoutesApiGateway implements RoutesPort {
  final SupabaseClient _client;

  RoutesApiGateway(this._client);

  @override
  Future<MapsRoutesModel> calculateRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _client.functions.invoke(
        'calculate-distance',
        body: json.encode({
          'origin': {
            'latitude': origin.latitude.toString(),
            'longitude': origin.longitude.toString(),
          },
          'destination': {
            'latitude': destination.latitude.toString(),
            'longitude': destination.longitude.toString(),
          },
        }),
      );

      return MapsRoutesModel.fromJson(response.data);
    } on FormatException catch (e) {
      throw DataParsingException(e.message);
    } on http.ClientException {
      throw ConnectionException('Failed to connect to the server');
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
