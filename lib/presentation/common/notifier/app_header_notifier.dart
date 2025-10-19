import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'package:lokapandu/common/errors/failure.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/common/services/location_service.dart';
import 'package:lokapandu/domain/entities/weather_entity.dart';
import 'package:lokapandu/domain/usecases/get_current_weather.dart';
import 'package:lokapandu/presentation/common/notifier/app_header_state.dart';

class AppHeaderNotifier extends ChangeNotifier {
  final LocationService _locationService;
  final AnalyticsManager _analyticsManager;
  final GetCurrentWeather _currentWeather;

  AppHeaderNotifier({
    required LocationService locationService,
    required GetCurrentWeather currentWeather,
    required AnalyticsManager analyticsManager,
  }) : _locationService = locationService,
       _currentWeather = currentWeather,
       _analyticsManager = analyticsManager;

  AppHeaderState _state = const AppHeaderLoading();
  AppHeaderState get state => _state;

  LocationData? _locationData;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Weather? get currentWeatherData {
    return switch (_state) {
      AppHeaderSuccess(weather: final weather) => weather,
      AppHeaderPermissionDenied(weather: final weather) => weather,
      _ => null,
    };
  }

  String get nowLocation {
    return switch (_state) {
      AppHeaderSuccess(location: final location) => location,
      AppHeaderPermissionDenied(fallbackLocation: final location) => location,
      AppHeaderLoading(message: final message) => message,
      AppHeaderError() => 'Error mendapatkan lokasi',
    };
  }

  bool get isLoadingWeather {
    return switch (_state) {
      AppHeaderSuccess(isWeatherLoading: final loading) => loading,
      AppHeaderPermissionDenied(isWeatherLoading: final loading) => loading,
      _ => false,
    };
  }

  bool isPermissionGranted() {
    return _permissionStatus == PermissionStatus.granted;
  }

  Future<void> initialize() async {
    dev.log('🎯 Jenderal memulai operasi...', name: 'AppHeaderNotifier');

    _updateState(const AppHeaderLoading(message: 'Mempersiapkan lokasi...'));

    try {
      // Delegasi ke Pasukan Intelijen
      final permissionGranted = await _ensureLocationPermission();

      if (permissionGranted) {
        // Delegasi ke Pasukan Penyerbu
        await _fetchLocationAndUpdateAddress();
      } else {
        // Fallback dengan state yang jelas
        _updateState(const AppHeaderPermissionDenied());
      }
    } catch (e, stackTrace) {
      dev.log(
        '❌ Operasi gagal: $e',
        name: 'AppHeaderNotifier',
        stackTrace: stackTrace,
      );
      _updateState(
        AppHeaderError(
          message: 'Gagal mendapatkan informasi lokasi',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  Future<bool> _ensureLocationPermission() async {
    dev.log('🕵️ Pasukan Intelijen beroperasi...', name: 'AppHeaderNotifier');

    _updateState(const AppHeaderLoading(message: 'Memeriksa izin lokasi...'));

    bool serviceEnabled = await _locationService.isServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak tersedia');
      }
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

    final granted = _permissionStatus == PermissionStatus.granted;
    dev.log(
      granted ? '✅ Izin diperoleh' : '❌ Izin ditolak',
      name: 'AppHeaderNotifier',
    );

    return granted;
  }

  Future<void> _fetchLocationAndUpdateAddress() async {
    dev.log('🚀 Pasukan Penyerbu menyerang...', name: 'AppHeaderNotifier');

    _updateState(const AppHeaderLoading(message: 'Mengambil data lokasi...'));

    try {
      _locationData = await _locationService.getCurrentLocation();

      await _analyticsManager.trackEvent(
        eventName: 'app_header_location_obtained',
        parameters: {
          'latitude': _locationData?.latitude.toString() ?? '0',
          'longitude': _locationData?.longitude.toString() ?? '0',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      final address = await _locationService.getAddressFromCoordinates(
        _locationData?.latitude ?? 0,
        _locationData?.longitude ?? 0,
      );

      _updateState(AppHeaderSuccess(location: address));

      dev.log('🎯 Misi berhasil: $address', name: 'AppHeaderNotifier');
    } catch (e) {
      dev.log('💥 Pasukan Penyerbu gagal: $e', name: 'AppHeaderNotifier');
      rethrow; // Biarkan error handling di level atas
    }
  }

  void _updateState(AppHeaderState newState) {
    _state = newState;
    notifyListeners();
  }

  void _handleFailure(Failure failure) {
    final errorMessage = failure.maybeWhen(
      server: (String message) => 'Server error: $message',
      connection: (String message) => 'Koneksi bermasalah: $message',
      database: (String message) => 'Database error: $message',
      orElse: () => 'Error tidak diketahui',
    );

    dev.log('🌡️ Weather failure: $errorMessage', name: 'AppHeaderNotifier');

    _state = switch (_state) {
      AppHeaderSuccess(location: final location) => AppHeaderSuccess(
        location: location,
        isWeatherLoading: false,
      ),
      AppHeaderPermissionDenied(fallbackLocation: final location) =>
        AppHeaderPermissionDenied(
          fallbackLocation: location,
          isWeatherLoading: false,
        ),
      _ => _state,
    };
    notifyListeners();
  }

  Future<void> getCurrentWeather() async {
    dev.log('🌡️ Memulai operasi cuaca...', name: 'AppHeaderNotifier');

    _state = switch (_state) {
      AppHeaderSuccess(location: final location, weather: final weather) =>
        AppHeaderSuccess(
          location: location,
          weather: weather,
          isWeatherLoading: true,
        ),
      AppHeaderPermissionDenied(
        fallbackLocation: final location,
        weather: final weather,
      ) =>
        AppHeaderPermissionDenied(
          fallbackLocation: location,
          weather: weather,
          isWeatherLoading: true,
        ),
      _ =>
        _state, // Jika state bukan success atau permission denied, jangan update
    };
    notifyListeners();

    try {
      final result = await _currentWeather.execute(
        latLon: isPermissionGranted()
            ? '${_locationData?.latitude},${_locationData?.longitude}'
            : 'Denpasar',
      );

      result.fold((failure) => _handleFailure(failure), (weather) {
        dev.log(
          '🌤️ Cuaca berhasil diperoleh: ${weather.text}',
          name: 'AppHeaderNotifier',
        );

        // Update state dengan data weather
        _state = switch (_state) {
          AppHeaderSuccess(location: final location) => AppHeaderSuccess(
            location: location,
            weather: weather,
            isWeatherLoading: false,
          ),
          AppHeaderPermissionDenied(fallbackLocation: final location) =>
            AppHeaderPermissionDenied(
              fallbackLocation: location,
              weather: weather,
              isWeatherLoading: false,
            ),
          _ => _state,
        };
        notifyListeners();
      });

      // Analytics tracking
      await _analyticsManager.trackEvent(
        eventName: 'get_weather_information',
        parameters: {
          'weather_status':
              currentWeatherData?.toString() ?? 'Cant Get Weather Data',
          'location_permission': isPermissionGranted().toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e, stackTrace) {
      dev.log(
        '❌ Error getting weather: $e',
        name: 'AppHeaderNotifier',
        stackTrace: stackTrace,
      );

      // Update state untuk menghilangkan loading
      _state = switch (_state) {
        AppHeaderSuccess(location: final location, weather: final weather) =>
          AppHeaderSuccess(
            location: location,
            weather: weather,
            isWeatherLoading: false,
          ),
        AppHeaderPermissionDenied(
          fallbackLocation: final location,
          weather: final weather,
        ) =>
          AppHeaderPermissionDenied(
            fallbackLocation: location,
            weather: weather,
            isWeatherLoading: false,
          ),
        _ => _state,
      };
      notifyListeners();
    }
  }
}
