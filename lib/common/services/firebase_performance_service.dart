import 'dart:developer' as developer;
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

/// Service class for Firebase Performance Monitoring
/// Handles custom traces and HTTP metrics
class FirebasePerformanceService {
  static final FirebasePerformanceService _instance = 
      FirebasePerformanceService._internal();
  
  factory FirebasePerformanceService() => _instance;
  
  FirebasePerformanceService._internal();
  
  final FirebasePerformance _performance = FirebasePerformance.instance;
  final Map<String, Trace> _activeTraces = {};
  
  static const String _debugTag = 'FirebasePerformanceService';

  /// Initialize the performance service
  Future<void> initialize() async {
    try {
      // Ensure performance collection is enabled
      await _performance.setPerformanceCollectionEnabled(true);
      
      if (kDebugMode) {
        developer.log('Firebase Performance initialized', name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log('Error initializing Firebase Performance: $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Start a custom trace
  /// 
  /// [traceName] - Name of the trace to start
  /// Returns the trace object or null if there was an error
  Future<Trace?> startTrace(String traceName) async {
    try {
      // Check if trace with this name is already running
      if (_activeTraces.containsKey(traceName)) {
        if (kDebugMode) {
          developer.log('Trace "$traceName" is already running', name: _debugTag);
        }
        return _activeTraces[traceName];
      }
      
      // Create and start a new trace
      final trace = _performance.newTrace(traceName);
      await trace.start();
      
      // Store in active traces
      _activeTraces[traceName] = trace;
      
      if (kDebugMode) {
        developer.log('Started trace: $traceName', name: _debugTag);
      }
      
      return trace;
    } catch (e) {
      if (kDebugMode) {
        developer.log('Error starting trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
      return null;
    }
  }

  /// Stop a custom trace
  /// 
  /// [traceName] - Name of the trace to stop
  Future<void> stopTrace(String traceName) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot stop trace "$traceName": not found', name: _debugTag);
        }
        return;
      }
      
      await trace.stop();
      _activeTraces.remove(traceName);
      
      if (kDebugMode) {
        developer.log('Stopped trace: $traceName', name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log('Error stopping trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Add a custom metric to a trace
  /// 
  /// [traceName] - Name of the trace
  /// [metricName] - Name of the metric
  /// [value] - Value to set for the metric
  Future<void> setMetric(String traceName, String metricName, int value) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot set metric for trace "$traceName": not found', 
              name: _debugTag);
        }
        return;
      }
      
      trace.setMetric(metricName, value);
      
      if (kDebugMode) {
        developer.log('Set metric "$metricName" = $value for trace "$traceName"', 
            name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log('Error setting metric "$metricName" for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Increment a custom metric in a trace
  /// 
  /// [traceName] - Name of the trace
  /// [metricName] - Name of the metric
  /// [incrementBy] - Value to increment the metric by (default: 1)
  Future<void> incrementMetric(
      String traceName, String metricName, [int incrementBy = 1]) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot increment metric for trace "$traceName": not found', 
              name: _debugTag);
        }
        return;
      }
      
      trace.incrementMetric(metricName, incrementBy);
      
      if (kDebugMode) {
        developer.log(
            'Incremented metric "$metricName" by $incrementBy for trace "$traceName"', 
            name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
            'Error incrementing metric "$metricName" for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Add a custom attribute to a trace
  /// 
  /// [traceName] - Name of the trace
  /// [attributeName] - Name of the attribute
  /// [value] - Value to set for the attribute
  Future<void> putAttribute(
      String traceName, String attributeName, String value) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot put attribute for trace "$traceName": not found', 
              name: _debugTag);
        }
        return;
      }
      
      trace.putAttribute(attributeName, value);
      
      if (kDebugMode) {
        developer.log(
            'Added attribute "$attributeName" = "$value" for trace "$traceName"', 
            name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
            'Error adding attribute "$attributeName" for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Remove a custom attribute from a trace
  /// 
  /// [traceName] - Name of the trace
  /// [attributeName] - Name of the attribute to remove
  Future<void> removeAttribute(String traceName, String attributeName) async {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot remove attribute for trace "$traceName": not found', 
              name: _debugTag);
        }
        return;
      }
      
      trace.removeAttribute(attributeName);
      
      if (kDebugMode) {
        developer.log('Removed attribute "$attributeName" from trace "$traceName"', 
            name: _debugTag);
      }
    } catch (e) {
      if (kDebugMode) {
        developer.log(
            'Error removing attribute "$attributeName" from trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
    }
  }

  /// Get all attributes for a trace
  /// 
  /// [traceName] - Name of the trace
  /// Returns a map of attribute names to values, or empty map if trace not found
  Map<String, String> getAttributes(String traceName) {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log('Cannot get attributes for trace "$traceName": not found', 
              name: _debugTag);
        }
        return {};
      }
      
      return trace.getAttributes();
    } catch (e) {
      if (kDebugMode) {
        developer.log('Error getting attributes for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
      return {};
    }
  }

  /// Get a specific attribute for a trace
  /// 
  /// [traceName] - Name of the trace
  /// [attributeName] - Name of the attribute to get
  /// Returns the attribute value or null if not found
  String? getAttribute(String traceName, String attributeName) {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log(
              'Cannot get attribute "$attributeName" for trace "$traceName": not found', 
              name: _debugTag);
        }
        return null;
      }
      
      return trace.getAttribute(attributeName);
    } catch (e) {
      if (kDebugMode) {
        developer.log(
            'Error getting attribute "$attributeName" for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
      return null;
    }
  }

  /// Get a specific metric for a trace
  /// 
  /// [traceName] - Name of the trace
  /// [metricName] - Name of the metric to get
  /// Returns the metric value or 0 if not found
  int getMetric(String traceName, String metricName) {
    try {
      final trace = _activeTraces[traceName];
      if (trace == null) {
        if (kDebugMode) {
          developer.log(
              'Cannot get metric "$metricName" for trace "$traceName": not found', 
              name: _debugTag);
        }
        return 0;
      }
      
      return trace.getMetric(metricName);
    } catch (e) {
      if (kDebugMode) {
        developer.log(
            'Error getting metric "$metricName" for trace "$traceName": $e', 
            name: _debugTag, level: 1000);
      }
      return 0;
    }
  }

  /// Check if performance collection is enabled
  Future<bool> isPerformanceCollectionEnabled() async {
    return await _performance.isPerformanceCollectionEnabled();
  }

  /// Enable or disable performance collection
  Future<void> setPerformanceCollectionEnabled(bool enabled) async {
    await _performance.setPerformanceCollectionEnabled(enabled);
  }
}