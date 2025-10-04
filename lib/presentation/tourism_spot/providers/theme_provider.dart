import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //  mulai  langsung dari light.
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  //  isDarkMode, tidak perlu cek sistem.
  bool get isDarkMode {
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
