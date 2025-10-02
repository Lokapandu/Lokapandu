import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'firebase_analytics_service.dart';
import 'debug_analytics_service.dart';
import '../config/environment_config.dart';
import '../config/firebase_debug_config.dart';

/// Analytics Manager
/// Centralized service that manages both Firebase Analytics and Debug Analytics
/// based on environment configuration and best practices
class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();
  factory AnalyticsManager() => _instance;
  AnalyticsManager._internal();

  // Services
  final FirebaseAnalyticsService _firebaseAnalytics = FirebaseAnalyticsService();
  final DebugAnalyticsService _debugAnalytics = DebugAnalyticsService();
  
  // Configuration
  late FirebaseAnalyticsConfig _config;
  bool _isInitialized = false;
  
  static const String _debugTag = 'AnalyticsManager';

  /// Initialize the analytics manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load environment configuration
      _config = EnvironmentConfig.analyticsConfig;
      
      // Initialize Firebase debug configuration if needed
      if (_config.enableDebugMode) {
        await FirebaseDebugConfig.initialize();
      }
      
      // Configure analytics collection
      await _firebaseAnalytics.setAnalyticsCollectionEnabled(_config.collectAnalytics);
      
      _isInitialized = true;
      
      _logDebug('Analytics Manager initialized successfully');
      _logDebug('Environment: ${EnvironmentConfig.environmentDisplayName}');
      _logDebug('Configuration: ${_config.toMap()}');
      
      // Print debug info if enabled
      if (_config.enableDebugMode) {
        FirebaseDebugConfig.printDebugInfo();
        if (_config.enableDebugView) {
          FirebaseDebugConfig.printManualSetupInstructions();
        }
      }
      
    } catch (e) {
      developer.log(
        'Failed to initialize Analytics Manager: $e',
        name: _debugTag,
        level: 1000,
      );
    }
  }

  /// Track page view events
  Future<void> trackPageView({
    required String screenName,
    String? screenClass,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
        'screen_name': screenName,
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackPageView(
        screenName: screenName,
        screenClass: screenClass,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackPageView(
          screenName: screenName,
          screenClass: screenClass,
          parameters: enrichedParameters,
        );
      }

      _logDebug('Page view tracked: $screenName');
    } catch (e) {
      _handleError('trackPageView', e);
    }
  }

  /// Track custom events
  Future<void> trackEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackEvent(
        eventName: eventName,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackEvent(
          eventName: eventName,
          parameters: enrichedParameters,
        );
      }

      _logDebug('Event tracked: $eventName');
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
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
        'action': action,
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackUserAction(
        action: action,
        category: category,
        label: label,
        value: value,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackUserAction(
          action: action,
          category: category,
          label: label,
          value: value,
          parameters: enrichedParameters,
        );
      }

      _logDebug('User action tracked: $action');
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
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
        'navigation_method': method,
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackNavigation(
        destination: destination,
        source: source,
        method: method,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackNavigation(
          destination: destination,
          source: source,
          method: method,
          parameters: enrichedParameters,
        );
      }

      _logDebug('Navigation tracked: ${source ?? 'Unknown'} -> $destination');
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
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
        'timing_category': category,
        'timing_variable': variable,
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackTiming(
        category: category,
        variable: variable,
        timeInMs: timeInMs,
        label: label,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackTiming(
          category: category,
          variable: variable,
          timeInMs: timeInMs,
          label: label,
          parameters: enrichedParameters,
        );
      }

      _logDebug('Timing tracked: $category.$variable = ${timeInMs}ms');
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
    if (!_isInitialized) await initialize();

    try {
      // Add environment context to parameters
      final enrichedParameters = _enrichParameters(parameters, {
        'environment': EnvironmentConfig.environment,
        'error_context': 'app_error',
      });

      // Track with Firebase Analytics
      await _firebaseAnalytics.trackError(
        error: error,
        description: description,
        fatal: fatal,
        parameters: enrichedParameters,
      );

      // Track with Debug Analytics if enabled
      if (_config.enableDebugMode) {
        await _debugAnalytics.trackError(
          error: error,
          description: description,
          fatal: fatal,
          parameters: enrichedParameters,
        );
      }

      _logDebug('Error tracked: $error');
    } catch (e) {
      _handleError('trackError', e);
    }
  }

  /// Set user properties
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      await _firebaseAnalytics.setUserProperty(name: name, value: value);
      _logDebug('User property set: $name = $value');
    } catch (e) {
      _handleError('setUserProperty', e);
    }
  }

  /// Set user ID
  Future<void> setUserId(String userId) async {
    if (!_isInitialized) await initialize();

    try {
      await _firebaseAnalytics.setUserId(userId);
      _logDebug('User ID set: $userId');
    } catch (e) {
      _handleError('setUserId', e);
    }
  }

  /// Reset analytics data
  Future<void> resetAnalyticsData() async {
    if (!_isInitialized) await initialize();

    try {
      await _firebaseAnalytics.resetAnalyticsData();
      _debugAnalytics.clearEvents();
      _logDebug('Analytics data reset');
    } catch (e) {
      _handleError('resetAnalyticsData', e);
    }
  }

  /// Get debug analytics summary (development only)
  void printDebugSummary() {
    if (_config.enableDebugMode) {
      _debugAnalytics.printSummary();
    }
  }

  /// Get debug events (development only)
  List<Map<String, dynamic>> getDebugEvents() {
    if (_config.enableDebugMode) {
      return _debugAnalytics.getAllEvents();
    }
    return [];
  }

  /// Clear debug events (development only)
  void clearDebugEvents() {
    if (_config.enableDebugMode) {
      _debugAnalytics.clearEvents();
    }
  }

  /// Get app instance ID for debugging
  Future<String?> getAppInstanceId() async {
    if (!_isInitialized) await initialize();
    return await _firebaseAnalytics.getAppInstanceId();
  }

  /// Enrich parameters with additional context
  Map<String, Object> _enrichParameters(
    Map<String, Object?>? originalParameters,
    Map<String, Object> additionalParameters,
  ) {
    final Map<String, Object> enriched = {};
    
    // Add original parameters (filter out nulls)
    if (originalParameters != null) {
      originalParameters.forEach((key, value) {
        if (value != null) {
          enriched[key] = value;
        }
      });
    }
    
    // Add additional parameters
    enriched.addAll(additionalParameters);
    
    // Add common context
    enriched['app_version'] = '1.0.0'; // Should come from package info
    enriched['platform'] = defaultTargetPlatform.name;
    enriched['debug_mode'] = kDebugMode;
    
    return enriched;
  }

  /// Log debug information
  void _logDebug(String message) {
    if (_config.enableConsoleLogging && kDebugMode) {
      developer.log(message, name: _debugTag);
    }
  }

  /// Handle errors
  void _handleError(String operation, dynamic error) {
    if (_config.enableConsoleLogging && kDebugMode) {
      developer.log(
        'Error in $operation: $error',
        name: _debugTag,
        level: 1000,
      );
    }
  }

  /// Get current configuration
  FirebaseAnalyticsConfig get config => _config;

  /// Check if initialized
  bool get isInitialized => _isInitialized;

  /// Check if debug mode is enabled
  bool get isDebugMode => _config.enableDebugMode;

  /// Get environment info
  Map<String, dynamic> get environmentInfo => {
    'environment': EnvironmentConfig.environment,
    'isDevelopment': EnvironmentConfig.isDevelopment,
    'isProduction': EnvironmentConfig.isProduction,
    'enableDebugFeatures': EnvironmentConfig.enableDebugFeatures,
    'analyticsConfig': _config.toMap(),
  };
}