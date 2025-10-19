import 'package:flutter/material.dart';

import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/utils/prefs_store.dart';

class AnalyticsProvider extends ChangeNotifier {
  final AnalyticsManager _analyticsManager;
  static const _key = "analytics_enabled_v1";

  AnalyticsProvider(this._analyticsManager);

  // Default to true (analytics enabled by default)
  bool _analyticsEnabled = true;

  bool get analyticsEnabled => _analyticsEnabled;

  Future<void> load() async {
    final prefs = await PrefsStore.instance;
    _analyticsEnabled = prefs.getBool(_key) ?? true; // Default to true

    // Apply the setting to the analytics manager
    await _analyticsManager.setAnalyticsCollectionEnabled(_analyticsEnabled);

    notifyListeners();
  }

  Future<void> toggleAnalytics() async {
    _analyticsEnabled = !_analyticsEnabled;
    notifyListeners();

    // Apply the setting to the analytics manager
    await _analyticsManager.setAnalyticsCollectionEnabled(_analyticsEnabled);

    // Track this event only if analytics is being enabled
    if (_analyticsEnabled) {
      await _analyticsManager.trackEvent(
        eventName: 'analytics_toggled',
        parameters: {'analytics_enabled': _analyticsEnabled},
      );
    }

    await save();
  }

  Future<void> save() async {
    final prefs = await PrefsStore.instance;
    await prefs.setBool(_key, _analyticsEnabled);
  }
}
