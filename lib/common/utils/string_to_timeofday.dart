import 'package:flutter/material.dart';

extension StringToTimeOfDay on String {
  TimeOfDay toTimeOfDay() {
    // Hilangkan offset jika ada
    String onlyTime = split('+')[0]; // "07:00:00"
    // Pecah jadi array jam, menit, detik
    List<String> parts = onlyTime.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
