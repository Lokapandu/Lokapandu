import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';

class AnalyticPageObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _trackScreen(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _trackScreen(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _trackScreen(previousRoute);
    }
  }

  void _trackScreen(Route<dynamic> route) {
    final screenName = route.settings.name;
    final screenClass = route.settings.arguments?.toString() ?? screenName;
    if (screenName != null) {
      FirebaseAnalyticsService().trackPageView(
        screenName: screenName,
        screenClass: screenClass,
        parameters: {'entry_time': DateTime.now().toIso8601String()},
      );
    }
  }
}
