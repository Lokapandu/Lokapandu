import 'package:flutter/material.dart';
import 'package:lokapandu/common/utils/prefs_store.dart';

class ThemeProvider extends ChangeNotifier {
  static const _key = "theme_mode_v1";

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
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    await save();
  }

  Future<void> save() async {
    final prefs = await PrefsStore.instance;
    await prefs.setBool(_key, _themeMode == ThemeMode.dark);
  }
}
