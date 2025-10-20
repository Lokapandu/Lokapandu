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

extension TimeOfDayToString on TimeOfDay {
  String toString24() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

extension TimeOfDayToDateTime on TimeOfDay {
  DateTime toDateTime() {
    final date = DateTime.now();
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

extension DateTimeToTimeOfDay on DateTime {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

