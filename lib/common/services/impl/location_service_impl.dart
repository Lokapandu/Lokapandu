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
    if (await getPermissionStatus() == PermissionStatus.granted) {
      return await _location.getLocation();
    }
    return null;
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
  Future<PermissionStatus> getPermissionStatus() async {
    return await _location.hasPermission();
  }

  @override
  Future<bool> isServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  @override
  Future<PermissionStatus> requestPermission() async {
    return await _location.requestPermission();
  }

  @override
  Future<bool> requestService() async {
    return await _location.requestService();
  }
}
