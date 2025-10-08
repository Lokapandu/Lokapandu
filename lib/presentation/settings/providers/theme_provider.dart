import 'package:flutter/material.dart';
import 'package:lokapandu/common/analytics.dart';
import 'package:lokapandu/common/utils/prefs_store.dart';

class ThemeProvider extends ChangeNotifier {
  final AnalyticsManager _analyticsManager;
  static const _key = "theme_mode_v1";

  ThemeProvider(this._analyticsManager);

  //  mulai  langsung dari light.
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  //  isDarkMode, tidak perlu cek sistem.
  bool get isDarkMode {
    return _themeMode == ThemeMode.dark;
  }

  Future<void> load() async {
    final prefs = await PrefsStore.instance;
    final isDarkMode = prefs.getBool(_key) ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    await _analyticsManager.setUserProperty(
      name: 'theme_mode',
      value: _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();

    await _analyticsManager.setUserProperty(
      name: 'theme_mode',
      value: _themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
    await _analyticsManager.trackEvent(
      eventName: 'theme_toggled',
      parameters: {
        'theme_mode': _themeMode == ThemeMode.dark ? 'dark' : 'light',
      },
    );
    await save();
  }

  Future<void> save() async {
    final prefs = await PrefsStore.instance;
    await prefs.setBool(_key, _themeMode == ThemeMode.dark);
    await _analyticsManager.trackEvent(
      eventName: 'theme_saved',
      parameters: {
        'theme_mode': _themeMode == ThemeMode.dark ? 'dark' : 'light',
      },
    );
  }
}
