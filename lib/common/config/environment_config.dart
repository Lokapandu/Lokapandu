import 'package:flutter/foundation.dart';

/// Environment configuration for the application
class EnvironmentConfig {
  static const String _environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: kDebugMode ? 'development' : 'production',
  );

  /// Current environment
  static String get environment => _environment;

  /// Check if running in development
  static bool get isDevelopment => _environment == 'development' || kDebugMode;

  /// Check if running in staging
  static bool get isStaging => _environment == 'staging';

  /// Check if running in production
  static bool get isProduction => _environment == 'production' && kReleaseMode;

  /// Firebase Analytics configuration
  static FirebaseAnalyticsConfig get analyticsConfig {
    switch (_environment) {
      case 'development':
        return FirebaseAnalyticsConfig.development();
      case 'staging':
        return FirebaseAnalyticsConfig.staging();
      case 'production':
        return FirebaseAnalyticsConfig.production();
      default:
        return kDebugMode
            ? FirebaseAnalyticsConfig.development()
            : FirebaseAnalyticsConfig.production();
    }
  }

  /// Get environment display name
  static String get environmentDisplayName {
    switch (_environment) {
      case 'development':
        return 'Development';
      case 'staging':
        return 'Staging';
      case 'production':
        return 'Production';
      default:
        return kDebugMode ? 'Development' : 'Production';
    }
  }

  /// Check if debug features should be enabled
  static bool get enableDebugFeatures => isDevelopment || isStaging;

  /// Check if analytics debug mode should be enabled
  static bool get enableAnalyticsDebug => isDevelopment;

  /// Check if verbose logging should be enabled
  static bool get enableVerboseLogging => isDevelopment || isStaging;
}

/// Firebase Analytics environment-specific configuration
class FirebaseAnalyticsConfig {
  final bool enableDebugMode;
  final bool enableDebugView;
  final bool enableConsoleLogging;
  final bool collectAnalytics;
  final String? debugAppInstanceId;
  final Duration eventUploadInterval;
  final int maxEventQueueSize;

  const FirebaseAnalyticsConfig({
    required this.enableDebugMode,
    required this.enableDebugView,
    required this.enableConsoleLogging,
    required this.collectAnalytics,
    this.debugAppInstanceId,
    required this.eventUploadInterval,
    required this.maxEventQueueSize,
  });

  /// Development configuration
  factory FirebaseAnalyticsConfig.development() {
    return const FirebaseAnalyticsConfig(
      enableDebugMode: true,
      enableDebugView: true,
      enableConsoleLogging: true,
      collectAnalytics: true,
      eventUploadInterval: Duration(seconds: 1), // Fast upload for debugging
      maxEventQueueSize: 100,
    );
  }

  /// Staging configuration
  factory FirebaseAnalyticsConfig.staging() {
    return const FirebaseAnalyticsConfig(
      enableDebugMode: true,
      enableDebugView: false,
      enableConsoleLogging: false,
      collectAnalytics: true,
      eventUploadInterval: Duration(seconds: 30),
      maxEventQueueSize: 500,
    );
  }

  /// Production configuration
  factory FirebaseAnalyticsConfig.production() {
    return const FirebaseAnalyticsConfig(
      enableDebugMode: false,
      enableDebugView: false,
      enableConsoleLogging: false,
      collectAnalytics: true,
      eventUploadInterval: Duration(minutes: 1),
      maxEventQueueSize: 1000,
    );
  }

  /// Get configuration summary for debugging
  Map<String, dynamic> toMap() {
    return {
      'enableDebugMode': enableDebugMode,
      'enableDebugView': enableDebugView,
      'enableConsoleLogging': enableConsoleLogging,
      'collectAnalytics': collectAnalytics,
      'debugAppInstanceId': debugAppInstanceId,
      'eventUploadInterval': eventUploadInterval.inSeconds,
      'maxEventQueueSize': maxEventQueueSize,
    };
  }
}

/// App flavor configuration
enum AppFlavor { development, staging, production }

/// App flavor helper
class FlavorConfig {
  static AppFlavor _flavor = AppFlavor.development;

  /// Set app flavor
  static void setFlavor(AppFlavor flavor) {
    _flavor = flavor;
  }

  /// Get current flavor
  static AppFlavor get flavor => _flavor;

  /// Check if development flavor
  static bool get isDevelopment => _flavor == AppFlavor.development;

  /// Check if staging flavor
  static bool get isStaging => _flavor == AppFlavor.staging;

  /// Check if production flavor
  static bool get isProduction => _flavor == AppFlavor.production;

  /// Get flavor name
  static String get flavorName => _flavor.name;

  /// Get app name with flavor suffix
  static String getAppName(String baseName) {
    switch (_flavor) {
      case AppFlavor.development:
        return '$baseName (Dev)';
      case AppFlavor.staging:
        return '$baseName (Staging)';
      case AppFlavor.production:
        return baseName;
    }
  }

  /// Get package name suffix
  static String get packageSuffix {
    switch (_flavor) {
      case AppFlavor.development:
        return '.dev';
      case AppFlavor.staging:
        return '.staging';
      case AppFlavor.production:
        return '';
    }
  }
}
