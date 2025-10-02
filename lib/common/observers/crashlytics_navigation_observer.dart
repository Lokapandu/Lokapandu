import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/crashlytics_service.dart';
import 'package:lokapandu/common/utils/error_handler.dart';

/// Navigation observer untuk melacak perubahan route
/// dan melaporkan navigation errors ke Crashlytics
class CrashlyticsNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logRouteChange('push', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logRouteChange('pop', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logRouteChange('replace', newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logRouteChange('remove', route, previousRoute);
  }

  void _logRouteChange(
    String action,
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    final routeName = _getRouteName(route);
    final previousRouteName = previousRoute != null 
        ? _getRouteName(previousRoute) 
        : 'none';

    // Log navigation action
    CrashlyticsService.log(
      'Navigation $action: $routeName (from: $previousRouteName)',
    );

    // Set custom keys for debugging
    CrashlyticsService.setCustomKeys({
      'current_route': routeName,
      'previous_route': previousRouteName,
      'navigation_action': action,
      'navigation_timestamp': DateTime.now().toIso8601String(),
    });

    // Use ErrorHandler for consistent logging
    ErrorHandler.logNavigation(
      routeName,
      arguments: {
        'action': action,
        'previous_route': previousRouteName,
      },
    );
  }

  String _getRouteName(Route<dynamic> route) {
    if (route.settings.name != null) {
      return route.settings.name!;
    }
    
    // Fallback untuk route tanpa nama
    return route.runtimeType.toString();
  }
}

/// Mixin untuk widget yang ingin melaporkan navigation errors
mixin NavigationErrorReporting {
  /// Report navigation error dengan context
  Future<void> reportNavigationError(
    dynamic error, {
    String? routeName,
    Map<String, dynamic>? routeArguments,
    StackTrace? stackTrace,
  }) async {
    await ErrorHandler.handleGenericError(
      error,
      stackTrace: stackTrace,
      context: 'Navigation Error',
      additionalData: {
        'route_name': routeName ?? 'unknown',
        'route_arguments': routeArguments?.toString() ?? 'none',
      },
    );
  }

  /// Safe navigation dengan error handling
  Future<T?> safeNavigate<T>(
    BuildContext context,
    Future<T?> Function() navigationAction, {
    String? routeName,
  }) async {
    try {
      return await navigationAction();
    } catch (error, stackTrace) {
      await reportNavigationError(
        error,
        routeName: routeName,
        stackTrace: stackTrace,
      );
      return null;
    }
  }
}