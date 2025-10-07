import 'package:location/location.dart';

abstract class LocationService {
  Future<bool> isServiceEnabled();
  Future<bool> requestService();
  Future<PermissionStatus> getPermissionStatus();
  Future<PermissionStatus> requestPermission();
  Future<LocationData?> getCurrentLocation();
  Future<String> getAddressFromCoordinates(double lat, double lon);
}
