import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'
    show placemarkFromCoordinates, Placemark;
import 'package:location/location.dart';
import 'dart:developer' as dev;

import 'package:lokapandu/common/services/analytics_manager.dart';

class AppHeaderNotifier extends ChangeNotifier {
  final Location _location;
  final AnalyticsManager _analyticsManager;

  AppHeaderNotifier({
    required Location location,
    required AnalyticsManager analyticsManager,
  }) : _location = location,
       _analyticsManager = analyticsManager;

  String _nowLocation = 'mendapatkan data...';
  String get nowLocation => _nowLocation;

  Future<void> initialize() async {
    dev.log('Getting location...', name: 'AppHeaderNotifier');

    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      await _analyticsManager.trackEvent(
        eventName: 'location_permission_requested',
        parameters: {
          'permission_status': permissionStatus.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      if (permissionStatus != PermissionStatus.granted) {
        _nowLocation = 'Bali, Indonesia';
        notifyListeners();
        return;
      }
    }

    LocationData locationData = await _location.getLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude ?? 0,
      locationData.longitude ?? 0,
    );

    _nowLocation =
        '${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}';
    notifyListeners();
  }
}
