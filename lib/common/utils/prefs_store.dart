import 'package:shared_preferences/shared_preferences.dart';

class PrefsStore {
  PrefsStore._();

  static SharedPreferences? _cache;

  static Future<SharedPreferences> get instance async =>
      _cache ??= await SharedPreferences.getInstance();
}
