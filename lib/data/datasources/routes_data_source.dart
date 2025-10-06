import 'package:http/http.dart' as http;
import 'package:lokapandu/data/models/map_route/maps_routes_model.dart';

abstract class RoutesDataSource {
  Future<MapsRoutesModel> calculateRoute(String latLon);
}

class RoutesDataSourceImpl implements RoutesDataSource {
  final http.Client client;

  RoutesDataSourceImpl({required this.client});

  @override
  Future<MapsRoutesModel> calculateRoute(String latLon) async {
    return MapsRoutesModel(routes: []);
  }
}
