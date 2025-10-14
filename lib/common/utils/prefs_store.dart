import 'package:shared_preferences/shared_preferences.dart';

class PrefsStore {
  PrefsStore._();

  static SharedPreferences? _cache;
  static const String _notificationStatusKey = 'notification_status';

  static Future<SharedPreferences> get instance async =>
      _cache ??= await SharedPreferences.getInstance();

  static Future<void> saveNotificationStatus(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationStatusKey, isEnabled);
  }

  static Future<bool> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationStatusKey) ?? true;
  }
}
