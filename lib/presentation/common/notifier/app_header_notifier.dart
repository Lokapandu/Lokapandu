import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'
    show placemarkFromCoordinates, Placemark;
import 'package:location/location.dart';
import 'package:lokapandu/common/errors/failure.dart';
import 'dart:developer' as dev;

import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';
import 'package:lokapandu/domain/usecases/get_current_weather.dart';

class AppHeaderNotifier extends ChangeNotifier {
  final Location _location;
  final AnalyticsManager _analyticsManager;
  final GetCurrentWeather _currentWeather;

  AppHeaderNotifier({
    required Location location,
    required GetCurrentWeather currentWeather,
    required AnalyticsManager analyticsManager,
  }) : _location = location,
       _currentWeather = currentWeather,
       _analyticsManager = analyticsManager;

  LocationData? _locationData;

  bool isLoadingWeather = false;
  PermissionStatus _permissionStatus = PermissionStatus.denied;
  Weather? _currentWeatherData;
  Weather? get currentWeatherData => _currentWeatherData;

  String _nowLocation = 'mendapatkan data...';
  String get nowLocation => _nowLocation;

  bool isPermissionGranted() {
    return _permissionStatus == PermissionStatus.granted;
  }

  Future<void> initialize() async {
    dev.log('Getting location...', name: 'AppHeaderNotifier');

    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      await _analyticsManager.trackEvent(
        eventName: 'location_permission_requested',
        parameters: {
          'permission_status': _permissionStatus.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      if (_permissionStatus != PermissionStatus.granted) {
        _nowLocation = 'Bali, Indonesia';
        notifyListeners();
        return;
      }
    }

    _locationData = await _location.getLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _locationData?.latitude ?? 0,
      _locationData?.longitude ?? 0,
    );

    _nowLocation =
        '${placemarks.first.subAdministrativeArea}, ${placemarks.first.administrativeArea}';
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    failure.when(
      server: (String message) => dev.log(message),
      connection: (String message) => dev.log(message),
      database: (String message) => dev.log(message),
    );
  }

  Future<void> getCurrentWeather() async {
    dev.log('Getting current weather...', name: 'AppHeaderNotifier');
    isLoadingWeather = true;
    notifyListeners();

    try {
      final result = await _currentWeather.execute(
        latLon: isPermissionGranted()
            ? '${_locationData?.latitude},${_locationData?.longitude}'
            : 'Denpasar',
      );

      result.fold((failure) => _handleFailure(failure), (weather) {
        _currentWeatherData = weather;
      });

      await _analyticsManager.trackEvent(
        eventName: 'get_weather_information',
        parameters: {
          'weather_status':
              _currentWeatherData?.toString() ?? 'Cant Get Weather Data',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      dev.log('Error getting current weather: $e', name: 'AppHeaderNotifier');
    } finally {
      isLoadingWeather = false;
    }

    notifyListeners();
  }
}
