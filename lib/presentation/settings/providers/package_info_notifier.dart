import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoNotifier extends ChangeNotifier {
  PackageInfo? _packageInfo;
  PackageInfo? get packageInfo => _packageInfo;

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
