import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:location/location.dart';
import 'package:lokapandu/common/services/location_service.dart';

// Anggap class LocationService ada di file lain
class LocationServiceImpl implements LocationService {
  final Location _location;

  LocationServiceImpl(this._location);

  @override
  Future<LocationData?> getCurrentLocation() async {
    return await _location.getLocation();
  }

  @override
  Future<String> getAddressFromCoordinates(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    if (placemarks.isNotEmpty) {
      final first = placemarks.first;
      return '${first.subAdministrativeArea}, ${first.administrativeArea}';
    }
    return 'Lokasi tidak ditemukan';
  }

  @override
  Future<PermissionStatus> getPermissionStatus() {
    // TODO: implement getPermissionStatus
    throw UnimplementedError();
  }

  @override
  Future<bool> isServiceEnabled() {
    // TODO: implement isServiceEnabled
    throw UnimplementedError();
  }

  @override
  Future<PermissionStatus> requestPermission() {
    // TODO: implement requestPermission
    throw UnimplementedError();
  }

  @override
  Future<bool> requestService() {
    // TODO: implement requestService
    throw UnimplementedError();
  }

  // ... implementasi method lainnya (isServiceEnabled, requestPermission, dll)
}
