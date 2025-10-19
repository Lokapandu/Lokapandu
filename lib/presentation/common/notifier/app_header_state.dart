import 'package:lokapandu/domain/entities/weather_entity.dart';

/// Sealed class untuk state management yang robust dan anti-panik
/// Memberikan kesadaran penuh kepada notifier tentang kondisi saat ini
sealed class AppHeaderState {
  const AppHeaderState();
}

/// State ketika sedang loading - "Saya sedang bekerja"
final class AppHeaderLoading extends AppHeaderState {
  final String message;

  const AppHeaderLoading({this.message = 'Memuat data...'});
}

/// State ketika berhasil - "Misi berhasil, ini datanya"
final class AppHeaderSuccess extends AppHeaderState {
  final String location;
  final Weather? weather;
  final bool isWeatherLoading;

  const AppHeaderSuccess({
    required this.location,
    this.weather,
    this.isWeatherLoading = false,
  });

  /// Copy with method untuk update state secara immutable
  AppHeaderSuccess copyWith({
    String? location,
    Weather? weather,
    bool? isWeatherLoading,
  }) {
    return AppHeaderSuccess(
      location: location ?? this.location,
      weather: weather ?? this.weather,
      isWeatherLoading: isWeatherLoading ?? this.isWeatherLoading,
    );
  }
}

/// State ketika error - "Ada masalah, ini pesan kesalahannya"
final class AppHeaderError extends AppHeaderState {
  final String message;
  final String? technicalDetails;

  const AppHeaderError({required this.message, this.technicalDetails});
}

/// State khusus untuk permission denied
final class AppHeaderPermissionDenied extends AppHeaderState {
  final String fallbackLocation;
  final Weather? weather;
  final bool isWeatherLoading;

  const AppHeaderPermissionDenied({
    this.fallbackLocation = 'Bali, Indonesia',
    this.weather,
    this.isWeatherLoading = false,
  });

  AppHeaderPermissionDenied copyWith({
    String? fallbackLocation,
    Weather? weather,
    bool? isWeatherLoading,
  }) {
    return AppHeaderPermissionDenied(
      fallbackLocation: fallbackLocation ?? this.fallbackLocation,
      weather: weather ?? this.weather,
      isWeatherLoading: isWeatherLoading ?? this.isWeatherLoading,
    );
  }
}
