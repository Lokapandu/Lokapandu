import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._internal();
  factory FirebaseAnalyticsService() => _instance;
  FirebaseAnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebasePerformance _performance = FirebasePerformance.instance;

  // Debug mode configuration
  static const bool _isDebugMode = kDebugMode;
  static const String _debugTag = 'FirebaseAnalytics';

  /// Filter out null values from parameters map
  Map<String, Object> _filterOutNulls(Map<String, Object?> parameters) {
    final Map<String, Object> filtered = <String, Object>{};
    parameters.forEach((String key, Object? value) {
      if (value != null) {
        // Ensure value is a supported type (String, num, bool)
        if (value is String || value is num || value is bool) {
          filtered[key] = value;
        } else {
          // Convert unsupported types to String
          filtered[key] = value.toString();
        }
      }
    });
    return filtered;
  }

  /// Log debug information in development mode
  void _logDebug(String message, {Map<String, Object?>? parameters}) {
    if (_isDebugMode) {
      developer.log(message, name: _debugTag, time: DateTime.now());

      if (parameters != null && parameters.isNotEmpty) {
        developer.log('Parameters: $parameters', name: _debugTag);
      }
    }
  }

  /// Handle errors with proper logging
  void _handleError(String operation, dynamic error) {
    if (_isDebugMode) {
      developer.log(
        'Error in $operation: $error',
        name: _debugTag,
        level: 1000, // Error level
      );
    }
    // In production, you might want to send this to crash reporting
  }

  /// Track page view events
  Future<void> trackPageView({
    required String screenName,
    String? screenClass,
    Map<String, Object?>? parameters,
  }) async {
    try {
      _logDebug('Tracking page view: $screenName', parameters: parameters);

      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
        parameters: parameters != null ? _filterOutNulls(parameters) : null,
      );

      _logDebug('Page view tracked successfully: $screenName');
    } catch (e) {
      _handleError('trackPageView', e);
    }
  }

  /// Track custom events
  Future<void> trackEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    try {
      _logDebug('Tracking event: $eventName', parameters: parameters);

      await _analytics.logEvent(
        name: eventName,
        parameters: parameters != null ? _filterOutNulls(parameters) : null,
      );

      _logDebug('Event tracked successfully: $eventName');
    } catch (e) {
      _handleError('trackEvent', e);
    }
  }

  /// Track user actions
  Future<void> trackUserAction({
    required String action,
    String? category,
    String? label,
    int? value,
    Map<String, Object?>? parameters,
  }) async {
    try {
      final Map<String, Object?> eventParams = {
        'action': action,
        if (category != null) 'category': category,
        if (label != null) 'label': label,
        if (value != null) 'value': value,
        if (parameters != null) ...parameters,
      };

      _logDebug('Tracking user action: $action', parameters: eventParams);

      await _analytics.logEvent(
        name: 'user_action',
        parameters: _filterOutNulls(eventParams),
      );

      _logDebug('User action tracked successfully: $action');
    } catch (e) {
      _handleError('trackUserAction', e);
    }
  }

  /// Track navigation events
  Future<void> trackNavigation({
    required String destination,
    String? source,
    required String method,
    Map<String, Object>? parameters,
  }) async {
    try {
      final Map<String, Object> eventParams = {
        'destination': destination,
        'method': method,
        if (source != null) 'source': source,
        if (parameters != null) ...parameters,
      };

      _logDebug(
        'Tracking navigation: $source -> $destination',
        parameters: eventParams,
      );

      await _analytics.logEvent(
        name: 'navigation',
        parameters: _filterOutNulls(eventParams),
      );

      _logDebug('Navigation tracked successfully: $source -> $destination');
    } catch (e) {
      _handleError('trackNavigation', e);
    }
  }

  /// Track timing events
  Future<void> trackTiming({
    required String category,
    required String variable,
    required int timeInMs,
    String? label,
    Map<String, Object>? parameters,
  }) async {
    try {
      final Map<String, Object> eventParameters = {
        'timing_category': category,
        'timing_variable': variable,
        'timing_value': timeInMs,
        if (label != null) 'timing_label': label,
        if (parameters != null) ...parameters,
      };

      _logDebug(
        'Tracking timing: $category.$variable = ${timeInMs}ms',
        parameters: eventParameters,
      );

      await _analytics.logEvent(
        name: 'timing_complete',
        parameters: eventParameters,
      );

      _logDebug('Timing tracked successfully: $category.$variable');
    } catch (e) {
      _handleError('trackTiming', e);
    }
  }

  /// Track errors
  Future<void> trackError({
    required String error,
    String? description,
    bool? fatal,
    Map<String, Object>? parameters,
  }) async {
    try {
      final Map<String, Object> eventParameters = {
        'error_message': error,
        if (description != null) 'error_description': description,
        if (fatal != null) 'fatal': fatal,
        if (parameters != null) ...parameters,
      };

      _logDebug('Tracking error: $error', parameters: eventParameters);

      await _analytics.logEvent(name: 'app_error', parameters: eventParameters);

      _logDebug('Error tracked successfully: $error');
    } catch (e) {
      _handleError('trackError', e);
    }
  }

  /// Set user properties
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      _logDebug('Setting user property: $name = $value');

      await _analytics.setUserProperty(
        name: name,
        value: value,
        callOptions: AnalyticsCallOptions(global: true),
      );

      _logDebug('User property set successfully: $name');
    } catch (e) {
      _handleError('setUserProperty', e);
    }
  }

  /// Set user ID
  Future<void> setUserId(String userId) async {
    try {
      _logDebug('Setting user ID: $userId');

      await _analytics.setUserId(id: userId);

      _logDebug('User ID set successfully');
    } catch (e) {
      _handleError('setUserId', e);
    }
  }

  /// Reset analytics data
  Future<void> resetAnalyticsData() async {
    try {
      _logDebug('Resetting analytics data');

      await _analytics.resetAnalyticsData();

      _logDebug('Analytics data reset successfully');
    } catch (e) {
      _handleError('resetAnalyticsData', e);
    }
  }

  /// Enable/disable analytics collection
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    try {
      _logDebug('Setting analytics collection enabled: $enabled');

      await _analytics.setAnalyticsCollectionEnabled(enabled);
      await _performance.setPerformanceCollectionEnabled(enabled);

      _logDebug('Analytics collection setting updated successfully');
    } catch (e) {
      _handleError('setAnalyticsCollectionEnabled', e);
    }
  }

  /// Get app instance ID for debugging
  Future<String?> getAppInstanceId() async {
    try {
      final appInstanceId = await _analytics.appInstanceId;
      _logDebug('App instance ID: $appInstanceId');
      return appInstanceId;
    } catch (e) {
      _handleError('getAppInstanceId', e);
      return null;
    }
  }

  /// Check if debug mode is enabled
  bool get isDebugMode => _isDebugMode;
}
