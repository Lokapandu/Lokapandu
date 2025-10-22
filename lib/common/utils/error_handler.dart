import 'dart:io';

import 'package:lokapandu/common/errors/exceptions.dart';
import 'package:lokapandu/common/services/crashlytics_service.dart';

/// Utility class untuk menangani berbagai jenis error
/// dan melaporkannya ke Crashlytics
class ErrorHandler {
  /// Handle Supabase errors
  static Future<void> handleSupabaseError(SupabaseException error) async {
    await CrashlyticsService.setCustomKeys({
      'error_type': 'supabase_error',
      'error_code': error.code ?? 'unknown',
      'error_message': error.message,
    });

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Supabase operation failed: ${error.message}',
    );
  }

  /// Handle server errors
  static Future<void> handleServerError(ServerException error) async {
    await CrashlyticsService.setCustomKeys({
      'error_type': 'server_error',
      'error_message': error.message,
    });

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Server error: ${error.message}',
    );
  }

  /// Handle connection errors
  static Future<void> handleConnectionError(ConnectionException error) async {
    await CrashlyticsService.setCustomKeys({
      'error_type': 'connection_error',
      'error_message': error.message,
    });

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Connection error: ${error.message}',
    );
  }

  /// Handle Socket exceptions
  static Future<void> handleSocketError(SocketException error) async {
    await CrashlyticsService.setCustomKeys({
      'error_type': 'socket_error',
      'host': error.address?.host ?? 'unknown',
      'port': error.port ?? 0,
      'os_error': error.osError?.message ?? 'unknown',
    });

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Socket connection failed',
    );
  }

  /// Handle format exceptions
  static Future<void> handleFormatError(FormatException error) async {
    await CrashlyticsService.setCustomKeys({
      'error_type': 'format_error',
      'source': error.source?.toString() ?? 'unknown',
      'offset': error.offset ?? 0,
    });

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Data format error',
    );
  }

  /// Handle type errors
  static Future<void> handleTypeError(TypeError error) async {
    await CrashlyticsService.setCustomKey('error_type', 'type_error');

    await CrashlyticsService.recordError(
      error,
      StackTrace.current,
      reason: 'Type casting error',
    );
  }

  /// Handle generic exceptions
  static Future<void> handleGenericError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
  }) async {
    // Set custom keys
    final customKeys = <String, dynamic>{
      'error_type': 'generic_error',
      'error_runtime_type': error.runtimeType.toString(),
    };

    if (context != null) {
      customKeys['error_context'] = context;
    }

    if (additionalData != null) {
      customKeys.addAll(additionalData);
    }

    await CrashlyticsService.setCustomKeys(customKeys);

    await CrashlyticsService.recordError(
      error,
      stackTrace ?? StackTrace.current,
      reason: context ?? 'Generic error occurred',
    );
  }

  /// Wrapper function untuk menjalankan code dengan error handling
  static Future<T?> safeExecute<T>(
    Future<T> Function() operation, {
    String? context,
    T? fallbackValue,
    bool reportError = true,
  }) async {
    try {
      return await operation();
    } on SupabaseException catch (e) {
      if (reportError) await handleSupabaseError(e);
      return fallbackValue;
    } on ServerException catch (e) {
      if (reportError) await handleServerError(e);
      return fallbackValue;
    } on ConnectionException catch (e) {
      if (reportError) await handleConnectionError(e);
      return fallbackValue;
    } on SocketException catch (e) {
      if (reportError) await handleSocketError(e);
      return fallbackValue;
    } on FormatException catch (e) {
      if (reportError) await handleFormatError(e);
      return fallbackValue;
    } on TypeError catch (e) {
      if (reportError) await handleTypeError(e);
      return fallbackValue;
    } catch (e, stackTrace) {
      if (reportError) {
        await handleGenericError(e, stackTrace: stackTrace, context: context);
      }
      return fallbackValue;
    }
  }

  /// Log user action untuk debugging
  static Future<void> logUserAction(
    String action, {
    Map<String, dynamic>? parameters,
  }) async {
    await CrashlyticsService.log('User Action: $action');

    if (parameters != null) {
      await CrashlyticsService.setCustomKeys({
        'last_user_action': action,
        'action_parameters': parameters.toString(),
      });
    }
  }

  /// Log navigation events
  static Future<void> logNavigation(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) async {
    await CrashlyticsService.log('Navigation: $routeName');

    await CrashlyticsService.setCustomKeys({
      'current_route': routeName,
      'route_arguments': arguments?.toString() ?? 'none',
    });
  }
}
