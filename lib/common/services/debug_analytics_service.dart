import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class DebugAnalyticsService {
  static final DebugAnalyticsService _instance =
      DebugAnalyticsService._internal();
  factory DebugAnalyticsService() => _instance;
  DebugAnalyticsService._internal();

  // Store events for debugging purposes
  final List<Map<String, dynamic>> _events = [];

  // Debug configuration
  static const String _debugTag = 'DebugAnalytics';
  static const bool _enableConsoleOutput = kDebugMode;

  // Allowed pages for tracking (can be expanded)
  static const Set<String> _allowedPages = {'splash', 'auth'};

  /// Track page view events
  Future<void> trackPageView({
    required String screenName,
    String? screenClass,
    Map<String, Object>? parameters,
  }) async {
    if (!_allowedPages.contains(screenName.toLowerCase())) return;

    final event = {
      'type': 'page_view',
      'screen_name': screenName,
      'screen_class': screenClass,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': screenName.toLowerCase(),
    };

    _events.add(event);
    _logEvent('Page View', event);
  }

  /// Track custom events
  Future<void> trackEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    // Extract page from parameters or event name
    final page =
        _extractPageFromParameters(parameters) ??
        _extractPageFromEventName(eventName);

    if (page != null && !_allowedPages.contains(page)) return;

    final event = {
      'type': 'custom_event',
      'event_name': eventName,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': page,
    };

    _events.add(event);
    _logEvent('Custom Event', event);
  }

  /// Track user actions
  Future<void> trackUserAction({
    required String action,
    String? category,
    String? label,
    int? value,
    Map<String, Object?>? parameters,
  }) async {
    final page =
        _extractPageFromParameters(parameters) ??
        _extractPageFromAction(action);

    if (page != null && !_allowedPages.contains(page)) return;

    final event = {
      'type': 'user_action',
      'action': action,
      'category': category,
      'label': label,
      'value': value,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': page,
    };

    _events.add(event);
    _logEvent('User Action', event);
  }

  /// Track navigation events
  Future<void> trackNavigation({
    required String destination,
    String? source,
    required String method,
    Map<String, Object>? parameters,
  }) async {
    final sourcePage = source?.toLowerCase();
    final destPage = destination.toLowerCase();

    // Track if either source or destination is in allowed pages
    if (sourcePage != null &&
        !_allowedPages.contains(sourcePage) &&
        !_allowedPages.contains(destPage)) {
      return;
    }

    final event = {
      'type': 'navigation',
      'destination': destination,
      'source': source,
      'method': method,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': sourcePage ?? destPage,
    };

    _events.add(event);
    _logEvent('Navigation', event);
  }

  /// Track timing events
  Future<void> trackTiming({
    required String category,
    required String variable,
    required int timeInMs,
    String? label,
    Map<String, Object>? parameters,
  }) async {
    final page =
        _extractPageFromParameters(parameters) ??
        _extractPageFromCategory(category);

    if (page != null && !_allowedPages.contains(page)) return;

    final event = {
      'type': 'timing',
      'category': category,
      'variable': variable,
      'time_ms': timeInMs,
      'label': label,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': page,
    };

    _events.add(event);
    _logEvent('Timing', event);
  }

  /// Track errors
  Future<void> trackError({
    required String error,
    String? description,
    bool? fatal,
    Map<String, Object>? parameters,
  }) async {
    final page = _extractPageFromParameters(parameters);

    if (page != null && !_allowedPages.contains(page)) return;

    final event = {
      'type': 'error',
      'error': error,
      'description': description,
      'fatal': fatal,
      'parameters': parameters,
      'timestamp': DateTime.now().toIso8601String(),
      'page': page,
    };

    _events.add(event);
    _logEvent('Error', event);
  }

  /// Log event with improved formatting
  void _logEvent(String eventType, Map<String, dynamic> event) {
    if (_enableConsoleOutput && kDebugMode) {
      developer.log(
        '[$eventType] ${event['type']?.toString().toUpperCase() ?? 'UNKNOWN'}',
        name: _debugTag,
        time: DateTime.now(),
      );

      // Log main event details
      final mainDetails = <String>[];

      switch (event['type']) {
        case 'page_view':
          mainDetails.add('Screen: ${event['screen_name']}');
          if (event['screen_class'] != null) {
            mainDetails.add('Class: ${event['screen_class']}');
          }
          break;
        case 'custom_event':
          mainDetails.add('Event: ${event['event_name']}');
          break;
        case 'user_action':
          mainDetails.add('Action: ${event['action']}');
          if (event['category'] != null) {
            mainDetails.add('Category: ${event['category']}');
          }
          break;
        case 'navigation':
          mainDetails.add(
            '${event['source'] ?? 'Unknown'} -> ${event['destination']}',
          );
          mainDetails.add('Method: ${event['method']}');
          break;
        case 'timing':
          mainDetails.add(
            '${event['category']}.${event['variable']}: ${event['time_ms']}ms',
          );
          break;
        case 'error':
          mainDetails.add('Error: ${event['error']}');
          if (event['fatal'] == true) {
            mainDetails.add('FATAL');
          }
          break;
      }

      if (mainDetails.isNotEmpty) {
        developer.log(mainDetails.join(' | '), name: _debugTag);
      }

      // Log parameters if present
      if (event['parameters'] != null &&
          (event['parameters'] as Map).isNotEmpty) {
        developer.log('Parameters: ${event['parameters']}', name: _debugTag);
      }

      // Log page context
      if (event['page'] != null) {
        developer.log('Page Context: ${event['page']}', name: _debugTag);
      }

      developer.log('---', name: _debugTag);
    }
  }

  /// Extract page from parameters
  String? _extractPageFromParameters(Map<String, Object?>? parameters) {
    if (parameters == null) return null;

    final page =
        parameters['page']?.toString().toLowerCase() ??
        parameters['screen']?.toString().toLowerCase() ??
        parameters['screen_name']?.toString().toLowerCase();

    return page;
  }

  /// Extract page from event name
  String? _extractPageFromEventName(String eventName) {
    final lowerEventName = eventName.toLowerCase();
    for (final page in _allowedPages) {
      if (lowerEventName.contains(page)) {
        return page;
      }
    }
    return null;
  }

  /// Extract page from action
  String? _extractPageFromAction(String action) {
    final lowerAction = action.toLowerCase();
    for (final page in _allowedPages) {
      if (lowerAction.contains(page)) {
        return page;
      }
    }
    return null;
  }

  /// Extract page from category
  String? _extractPageFromCategory(String category) {
    final lowerCategory = category.toLowerCase();
    for (final page in _allowedPages) {
      if (lowerCategory.contains(page)) {
        return page;
      }
    }
    return null;
  }

  /// Get all events
  List<Map<String, dynamic>> getAllEvents() {
    return List.unmodifiable(_events);
  }

  /// Get events by page
  List<Map<String, dynamic>> getEventsByPage(String page) {
    return _events
        .where((event) => event['page'] == page.toLowerCase())
        .toList();
  }

  /// Get events by type
  List<Map<String, dynamic>> getEventsByType(String type) {
    return _events.where((event) => event['type'] == type).toList();
  }

  /// Clear all events
  void clearEvents() {
    if (kDebugMode && _enableConsoleOutput) {
      developer.log(
        'Clearing ${_events.length} debug analytics events',
        name: _debugTag,
      );
    }
    _events.clear();
  }

  /// Print summary of all events
  void printSummary() {
    if (kDebugMode && _enableConsoleOutput) {
      developer.log('=== DEBUG ANALYTICS SUMMARY ===', name: _debugTag);

      developer.log('Total Events: ${_events.length}', name: _debugTag);

      // Group by type
      final eventsByType = <String, int>{};
      final eventsByPage = <String, int>{};

      for (final event in _events) {
        final type = event['type'] as String? ?? 'unknown';
        final page = event['page'] as String? ?? 'unknown';

        eventsByType[type] = (eventsByType[type] ?? 0) + 1;
        eventsByPage[page] = (eventsByPage[page] ?? 0) + 1;
      }

      developer.log('Events by Type:', name: _debugTag);
      eventsByType.forEach((type, count) {
        developer.log('  $type: $count', name: _debugTag);
      });

      developer.log('Events by Page:', name: _debugTag);
      eventsByPage.forEach((page, count) {
        developer.log('  $page: $count', name: _debugTag);
      });

      developer.log('=== END SUMMARY ===', name: _debugTag);
    }
  }

  /// Get debug status
  bool get isDebugEnabled => _enableConsoleOutput && kDebugMode;

  /// Get allowed pages
  Set<String> get allowedPages => Set.unmodifiable(_allowedPages);

  /// Get events count
  int get eventsCount => _events.length;
}
