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
        await getCurrentWeather();
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
      _analyticsManager.trackError(
        error: e.runtimeType.toString(),
        description: '$e',
        parameters: {
          'get': 'location',
          'timestamp': DateTime.now().toIso8601String(),
          'stackTrace': stackTrace.toString(),
        },
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
        eventName: 'appHeader_location_obtained',
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

  /// Mengambil data cuaca terkini berdasarkan lokasi pengguna.
  ///
  /// Jika izin lokasi diberikan, akan menggunakan koordinat pengguna.
  /// Jika tidak, akan menggunakan lokasi default (Denpasar).
  ///
  /// Metode ini menangani state loading, error, dan sukses.
  Future<void> getCurrentWeather() async {
    dev.log('🌡️ Memulai operasi cuaca...', name: 'AppHeaderNotifier');

    // Fungsi helper untuk mengubah state ke mode loading
    void setLoadingState() {
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
    }

    // Fungsi helper untuk mengubah state ke mode tidak loading
    void setNotLoadingState() {
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
    }

    // Set state loading dan notify
    setLoadingState();
    notifyListeners();

    try {
      // Pastikan lokasi sudah diinisialisasi jika akses lokasi dibolehkan
      if (isPermissionGranted() && _locationData == null) {
        dev.log('⏳ Menunggu inisialisasi lokasi...', name: 'AppHeaderNotifier');
        try {
          _locationData = await _locationService.getCurrentLocation();
        } catch (e, st) {
          dev.log(
            '⚠️ Gagal mendapatkan lokasi: $e, menggunakan fallback',
            stackTrace: st,
            name: 'AppHeaderNotifier',
          );
          // Lanjutkan dengan fallback, tidak perlu rethrow
        }
      }

      // Gunakan lokasi pengguna jika tersedia, atau fallback ke Denpasar
      final latLonData = (isPermissionGranted() && _locationData != null)
          ? '${_locationData!.latitude},${_locationData!.longitude}'
          : 'Denpasar'; // Lokasi default untuk Bali

      // Tambahkan timeout untuk menghindari permintaan yang terlalu lama
      final result = await _currentWeather.execute(latLon: latLonData);

      // Tangani hasil
      result.fold(
        (failure) {
          // Tangani kegagalan
          _handleFailure(failure);

          // Tracking analytics untuk kegagalan
          _analyticsManager.trackEvent(
            eventName: 'get_weather_information_failed',
            parameters: {
              'failure_type': failure.runtimeType.toString(),
              'failure_message': failure.toString(),
              'location_permission': isPermissionGranted().toString(),
              'location_initialized': (_locationData != null).toString(),
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
        },
        (weather) {
          dev.log(
            '🌤️ Cuaca berhasil diperoleh: ${weather.text}',
            name: 'AppHeaderNotifier',
          );

          // Update state dengan data weather yang baru
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

          // Tracking analytics untuk keberhasilan
          _analyticsManager.trackEvent(
            eventName: 'get_weather_information_success',
            parameters: {
              'weather_location': weather.city,
              'weather_region': weather.region,
              'weather_country': weather.country,
              'weather_last_updated': weather.lastUpdated,
              'weather_timezone': weather.tzId,
              'weather_temperature': '${weather.celciusTemperature}°C',
              'weather_text': weather.text,
              'location_permission': isPermissionGranted().toString(),
              'location_initialized': (_locationData != null).toString(),
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
        },
      );
    } on TimeoutException catch (e, stackTrace) {
      dev.log(
        '⏱️ Timeout getting weather: $e',
        name: 'AppHeaderNotifier',
        stackTrace: stackTrace,
      );

      setNotLoadingState();
      notifyListeners();

      // Tracking untuk timeout
      _analyticsManager.trackError(
        error: 'TimeoutException',
        description: 'Weather request timed out: $e',
        parameters: {'timestamp': DateTime.now().toIso8601String()},
      );
    } catch (e, stackTrace) {
      dev.log(
        '❌ Error getting weather: $e',
        name: 'AppHeaderNotifier',
        stackTrace: stackTrace,
      );

      // Update state untuk menghilangkan loading
      setNotLoadingState();
      notifyListeners();

      // Tracking untuk error umum
      _analyticsManager.trackError(
        error: e.runtimeType.toString(),
        description: 'Error getting weather: $e',
        parameters: {
          'stackTrace': stackTrace.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    }
  }
}
