/// Example: How to use Firebase Analytics with AnalyticsManager
/// 
/// This file demonstrates best practices for implementing Firebase Analytics
/// in your Flutter app using the AnalyticsManager.

import 'package:flutter/material.dart';
import '../analytics.dart';

/// Example: Initialize Analytics in main.dart
/// 
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   // Initialize Firebase
///   await Firebase.initializeApp();
///   
///   // Initialize Analytics Manager
///   await AnalyticsManager().initialize();
///   
///   runApp(MyApp());
/// }
/// ```

/// Example: Track page views in your screens
class ExampleHomeScreen extends StatefulWidget {
  const ExampleHomeScreen({Key? key}) : super(key: key);

  @override
  State<ExampleHomeScreen> createState() => _ExampleHomeScreenState();
}

class _ExampleHomeScreenState extends State<ExampleHomeScreen> {
  final AnalyticsManager _analytics = AnalyticsManager();

  @override
  void initState() {
    super.initState();
    _trackPageView();
  }

  /// Track page view when screen loads
  void _trackPageView() {
    _analytics.trackPageView(
      screenName: 'home',
      screenClass: 'ExampleHomeScreen',
      parameters: {
        'section': 'main',
        'user_type': 'authenticated',
      },
    );
  }

  /// Track button clicks
  void _onButtonPressed(String buttonName) {
    _analytics.trackUserAction(
      action: 'button_click',
      category: 'ui_interaction',
      label: buttonName,
      parameters: {
        'screen': 'home',
        'button_type': 'primary',
      },
    );
  }

  /// Track custom events
  void _onFeatureUsed(String featureName) {
    _analytics.trackEvent(
      eventName: 'feature_used',
      parameters: {
        'feature_name': featureName,
        'screen': 'home',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  /// Track navigation
  void _navigateToProfile() {
    _analytics.trackNavigation(
      destination: 'profile',
      source: 'home',
      method: 'button_click',
      parameters: {
        'navigation_type': 'main_menu',
      },
    );
    
    // Navigate to profile screen
    Navigator.pushNamed(context, '/profile');
  }

  /// Track timing events
  void _trackLoadTime() {
    final stopwatch = Stopwatch()..start();
    
    // Simulate some operation
    Future.delayed(Duration(seconds: 2), () {
      stopwatch.stop();
      
      _analytics.trackTiming(
        category: 'performance',
        variable: 'home_load_time',
        timeInMs: stopwatch.elapsedMilliseconds,
        label: 'initial_load',
        parameters: {
          'screen': 'home',
          'cache_hit': false,
        },
      );
    });
  }

  /// Track errors
  void _handleError(dynamic error, StackTrace stackTrace) {
    _analytics.trackError(
      error: error.toString(),
      description: 'Error in home screen',
      fatal: false,
      parameters: {
        'screen': 'home',
        'error_type': error.runtimeType.toString(),
        'stack_trace': stackTrace.toString().substring(0, 500), // Limit length
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics Example'),
        actions: [
          // Debug button (only in debug mode)
          if (_analytics.isDebugMode)
            IconButton(
              icon: Icon(Icons.bug_report),
              onPressed: () => _showDebugInfo(context),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _onButtonPressed('primary_action'),
              child: Text('Primary Action'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _onFeatureUsed('search'),
              child: Text('Use Search Feature'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToProfile,
              child: Text('Go to Profile'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _trackLoadTime,
              child: Text('Test Load Time'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _handleError(
                Exception('Test error'),
                StackTrace.current,
              ),
              child: Text('Test Error Tracking'),
            ),
            SizedBox(height: 32),
            if (_analytics.isDebugMode) ...[
              Text(
                'Debug Mode Active',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Environment: ${_analytics.environmentInfo['environment']}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Show debug information (development only)
  void _showDebugInfo(BuildContext context) {
    if (!_analytics.isDebugMode) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Analytics Debug Info'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Environment Info:'),
              Text(
                _analytics.environmentInfo.toString(),
                style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
              SizedBox(height: 16),
              Text('Recent Events:'),
              ...(_analytics.getDebugEvents().take(5).map(
                (event) => Text(
                  '${event['eventType']}: ${event['eventName']}',
                  style: TextStyle(fontSize: 12),
                ),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _analytics.printDebugSummary();
              Navigator.pop(context);
            },
            child: Text('Print Summary'),
          ),
          TextButton(
            onPressed: () {
              _analytics.clearDebugEvents();
              Navigator.pop(context);
            },
            child: Text('Clear Events'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Example: User authentication tracking
class ExampleAuthService {
  final AnalyticsManager _analytics = AnalyticsManager();

  Future<void> login(String method) async {
    try {
      // Perform login logic
      await _performLogin(method);
      
      // Track successful login
      await _analytics.trackEvent(
        eventName: 'login',
        parameters: {
          'method': method,
          'success': true,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
      
      // Set user properties
      await _analytics.setUserId('user_123');
      await _analytics.setUserProperty(name: 'login_method', value: method);
      
    } catch (error) {
      // Track failed login
      await _analytics.trackEvent(
        eventName: 'login',
        parameters: {
          'method': method,
          'success': false,
          'error': error.toString(),
        },
      );
      
      // Track error
      await _analytics.trackError(
        error: 'Login failed',
        description: 'User login attempt failed with method: $method',
        fatal: false,
        parameters: {
          'login_method': method,
          'error_details': error.toString(),
        },
      );
      
      rethrow;
    }
  }

  Future<void> logout() async {
    await _analytics.trackEvent(
      eventName: 'logout',
      parameters: {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
    
    // Reset analytics data for privacy
    await _analytics.resetAnalyticsData();
  }

  Future<void> _performLogin(String method) async {
    // Simulate login logic
    await Future.delayed(Duration(seconds: 1));
  }
}

/// Example: E-commerce tracking
class ExampleEcommerceTracking {
  final AnalyticsManager _analytics = AnalyticsManager();

  /// Track product view
  Future<void> trackProductView({
    required String productId,
    required String productName,
    required String category,
    required double price,
  }) async {
    await _analytics.trackEvent(
      eventName: 'view_item',
      parameters: {
        'item_id': productId,
        'item_name': productName,
        'item_category': category,
        'price': price,
        'currency': 'IDR',
      },
    );
  }

  /// Track add to cart
  Future<void> trackAddToCart({
    required String productId,
    required String productName,
    required double price,
    required int quantity,
  }) async {
    await _analytics.trackEvent(
      eventName: 'add_to_cart',
      parameters: {
        'item_id': productId,
        'item_name': productName,
        'price': price,
        'quantity': quantity,
        'currency': 'IDR',
        'value': price * quantity,
      },
    );
  }

  /// Track purchase
  Future<void> trackPurchase({
    required String transactionId,
    required double totalValue,
    required List<Map<String, dynamic>> items,
  }) async {
    await _analytics.trackEvent(
      eventName: 'purchase',
      parameters: {
        'transaction_id': transactionId,
        'value': totalValue,
        'currency': 'IDR',
        'items': items,
        'payment_method': 'credit_card',
      },
    );
  }
}

/// Example: Performance tracking
class ExamplePerformanceTracking {
  final AnalyticsManager _analytics = AnalyticsManager();

  /// Track app startup time
  Future<void> trackAppStartup(int startupTimeMs) async {
    await _analytics.trackTiming(
      category: 'app_performance',
      variable: 'startup_time',
      timeInMs: startupTimeMs,
      label: 'cold_start',
      parameters: {
        'app_version': '1.0.0',
        'device_type': 'mobile',
      },
    );
  }

  /// Track API response time
  Future<void> trackApiCall({
    required String endpoint,
    required int responseTimeMs,
    required bool success,
  }) async {
    await _analytics.trackTiming(
      category: 'api_performance',
      variable: 'response_time',
      timeInMs: responseTimeMs,
      label: endpoint,
      parameters: {
        'endpoint': endpoint,
        'success': success,
        'network_type': 'wifi', // Could be detected
      },
    );
  }

  /// Track screen load time
  Future<void> trackScreenLoad({
    required String screenName,
    required int loadTimeMs,
  }) async {
    await _analytics.trackTiming(
      category: 'screen_performance',
      variable: 'load_time',
      timeInMs: loadTimeMs,
      label: screenName,
      parameters: {
        'screen_name': screenName,
        'cache_used': false,
      },
    );
  }
}