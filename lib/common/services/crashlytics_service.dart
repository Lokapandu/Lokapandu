import 'package:flutter/foundation.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Service untuk mengelola Firebase Crashlytics
/// Menyediakan metode untuk logging error, crash, dan informasi debugging
class CrashlyticsService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Inisialisasi Crashlytics dengan konfigurasi dasar
  static Future<void> initialize() async {
    // Set collection enabled berdasarkan mode debug
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

    // Log bahwa Crashlytics telah diinisialisasi
    await _crashlytics.log('Crashlytics initialized successfully');
  }

  /// Record error non-fatal ke Crashlytics
  /// [error] - Error yang terjadi
  /// [stackTrace] - Stack trace dari error
  /// [reason] - Alasan atau konteks tambahan
  static Future<void> recordError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    await _crashlytics.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: fatal,
    );
  }

  /// Record Flutter error ke Crashlytics
  /// [errorDetails] - Detail error dari Flutter
  static Future<void> recordFlutterError(
    FlutterErrorDetails errorDetails,
  ) async {
    await _crashlytics.recordFlutterFatalError(errorDetails);
  }

  /// Log custom message ke Crashlytics
  /// [message] - Pesan yang akan di-log
  static Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  /// Set user identifier untuk tracking
  /// [userId] - ID unik user
  static Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }

  /// Set custom key-value untuk debugging
  /// [key] - Key untuk custom data
  /// [value] - Value untuk custom data
  static Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Set multiple custom keys sekaligus
  /// [customKeys] - Map berisi key-value pairs
  static Future<void> setCustomKeys(Map<String, dynamic> customKeys) async {
    for (final entry in customKeys.entries) {
      await _crashlytics.setCustomKey(entry.key, entry.value);
    }
  }

  /// Force crash untuk testing (hanya untuk development)
  /// JANGAN gunakan di production!
  static void forceCrash() {
    if (kDebugMode) {
      _crashlytics.crash();
    }
  }

  /// Test crash dengan exception
  /// Berguna untuk testing apakah Crashlytics berfungsi
  static Future<void> testCrash() async {
    try {
      throw Exception('Test crash from Crashlytics Service');
    } catch (error, stackTrace) {
      await recordError(
        error,
        stackTrace,
        reason: 'Testing Crashlytics functionality',
        fatal: false,
      );
    }
  }

  /// Record network error
  /// [url] - URL yang error
  /// [statusCode] - HTTP status code
  /// [error] - Error message
  static Future<void> recordNetworkError(
    String url,
    int statusCode,
    String error,
  ) async {
    await setCustomKeys({
      'network_url': url,
      'status_code': statusCode,
      'error_type': 'network_error',
    });

    await recordError(
      'Network Error: $error',
      StackTrace.current,
      reason: 'Network request failed for $url with status $statusCode',
    );
  }

  /// Record authentication error
  /// [error] - Error yang terjadi saat authentication
  static Future<void> recordAuthError(dynamic error) async {
    await setCustomKey('error_type', 'authentication_error');
    await recordError(
      error,
      StackTrace.current,
      reason: 'Authentication failed',
    );
  }

  /// Record database error
  /// [operation] - Operasi database yang error (insert, update, delete, etc.)
  /// [error] - Error yang terjadi
  static Future<void> recordDatabaseError(
    String operation,
    dynamic error,
  ) async {
    await setCustomKeys({
      'error_type': 'database_error',
      'database_operation': operation,
    });

    await recordError(
      error,
      StackTrace.current,
      reason: 'Database operation failed: $operation',
    );
  }
}
