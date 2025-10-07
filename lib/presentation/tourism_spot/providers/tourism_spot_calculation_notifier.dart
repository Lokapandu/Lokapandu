import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/services/location_service.dart';
import 'package:lokapandu/domain/usecases/get_distance.dart';
import 'dart:developer' as dev;

class TourismSpotCalculationNotifier extends ChangeNotifier {
  final GetDistance _getDistance;
  final LocationService _locationService;
  final AnalyticsManager _analyticsManager;

  TourismSpotCalculationNotifier({
    required GetDistance getDistance,
    required LocationService locationService,
    required AnalyticsManager analyticsManager,
  }) : _getDistance = getDistance,
       _locationService = locationService,
       _analyticsManager = analyticsManager;

  LocationData? _locationData;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  bool isPermissionGranted() => _permissionStatus == PermissionStatus.granted;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _distance;
  String? get distance => _distance;

  Future<void> initialize() async {
    dev.log('Getting location...', name: 'AppHeaderNotifier');

    // Gunakan method dari service, bukan dari package langsung
    bool serviceEnabled = await _locationService.isServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) return;
      notifyListeners();
    }

    _permissionStatus = await _locationService.getPermissionStatus();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _locationService.requestPermission();
      await _analyticsManager.trackEvent(
        eventName: 'location_permission_requested',
        parameters: {
          'permission_status': _permissionStatus.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    }

    _locationData = await _locationService.getCurrentLocation();
    await _analyticsManager.trackEvent(
      eventName: 'tourism_spot-calculation_location_obtained',
      parameters: {
        'latitude': _locationData?.latitude.toString() ?? '0',
        'longitude': _locationData?.longitude.toString() ?? '0',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    notifyListeners();
  }

  Future<void> calculateDistance(LatLng destination) async {
    _isLoading = true;
    await initialize();
    notifyListeners();

    if (_locationData == null) return;

    final distance = await _getDistance.execute(
      origin: LatLng(
        _locationData?.latitude ?? 0,
        _locationData?.longitude ?? 0,
      ),
      destination: destination,
    );
    await _analyticsManager.trackEvent(
      eventName: 'distance_calculated',
      parameters: {
        'origin_latitude': _locationData?.latitude.toString() ?? '0',
        'origin_longitude': _locationData?.longitude.toString() ?? '0',
        'destination_latitude': destination.latitude.toString(),
        'destination_longitude': destination.longitude.toString(),
        'distance': distance.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    distance.fold(
      (l) => dev.log('Error: $l', name: 'TourismSpotCalculationNotifier'),
      (r) {
        final meters = double.tryParse(r.distanceMeters.toString()) ?? 0;
        if (meters < 1000) {
          _distance = '${meters.toInt()} m';
        } else {
          _distance = '${(meters / 1000).toStringAsFixed(1)} KM';
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
