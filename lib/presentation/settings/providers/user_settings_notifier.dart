import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettingsNotifier extends ChangeNotifier {
  final SupabaseClient _client;

  User? _user;
  get user => _user;

  UserSettingsNotifier(this._client);

  Future<void> init() async {
    _user = _client.auth.currentUser;
    notifyListeners();
  }
}
