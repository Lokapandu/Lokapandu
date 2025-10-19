import 'package:flutter/foundation.dart';
import 'package:lokapandu/common/services/notification_service.dart';
import 'package:lokapandu/common/utils/prefs_store.dart';

class NotificationSettingsNotifier extends ChangeNotifier {
  NotificationSettingsNotifier() {
    _loadNotificationStatus();
  }

  final NotificationService _notificationService = NotificationService();
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  Future<void> _loadNotificationStatus() async {
    _isNotificationEnabled = await PrefsStore.getNotificationStatus();
    notifyListeners();
  }

  Future<void> setNotificationStatus(bool isEnabled) async {
    _isNotificationEnabled = isEnabled;
    notifyListeners();

    await PrefsStore.saveNotificationStatus(isEnabled);

    if (isEnabled) {
      await _notificationService.subscribeToGeneralTopic();
    } else {
      await _notificationService.unsubscribeFromGeneralTopic();
    }
  }
}
