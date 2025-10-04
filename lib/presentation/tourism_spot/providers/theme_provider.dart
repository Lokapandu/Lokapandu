import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  // Defaultnya mengikuti tema sistem
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Getter untuk mengecek apakah mode saat ini adalah gelap
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      // Jika tema sistem, cek pengaturan brightness dari perangkat
      return SchedulerBinding.instance.platformBrightness == Brightness.dark;
    } else {
      // Jika diatur manual, langsung cek nilainya
      return _themeMode == ThemeMode.dark;
    }
  }

  // Fungsi untuk mengganti tema
  void toggleTheme(bool value) {
    // Jika sedang gelap (baik manual maupun sistem), ganti ke terang.
    // Jika sedang terang, ganti ke gelap.
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

extension on SchedulerBinding {
  get platformBrightness => null;
}