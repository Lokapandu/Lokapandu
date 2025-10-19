/// Firebase Analytics Implementation
///
/// This module provides a comprehensive Firebase Analytics implementation
/// following best practices for Flutter development, including:
///
/// - Environment separation (development/staging/production)
/// - Debug mode configuration with DebugView support
/// - Centralized analytics management
/// - Platform-specific debug setup
/// - Comprehensive event tracking
///
/// Usage:
/// ```dart
/// // Initialize analytics
/// await AnalyticsManager().initialize();
///
/// // Track events
/// await AnalyticsManager().trackPageView(screenName: 'home');
/// await AnalyticsManager().trackEvent(eventName: 'button_click');
/// await AnalyticsManager().trackUserAction(action: 'login');
/// ```
library;

// Configuration
export 'config/environment_config.dart';
export 'config/firebase_debug_config.dart';
export 'services/analytics_manager.dart';
export 'services/debug_analytics_service.dart';
// Core Services
export 'services/firebase_analytics_service.dart';
