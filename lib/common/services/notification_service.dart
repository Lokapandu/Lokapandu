import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:lokapandu/common/utils/prefs_store.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static const String notificationTopic = 'general_notifications';

  Future<void> initialize() async {
    await _requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print(
          'Pesan diterima saat aplikasi di foreground: ${message.messageId}',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Aplikasi dibuka dari notifikasi: ${message.messageId}');
      }
    });

    await syncSubscriptionStatus();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('Izin notifikasi diberikan oleh pengguna.');
      } else {
        print('Izin notifikasi ditolak oleh pengguna.');
      }
    }
  }

  Future<void> subscribeToGeneralTopic() async {
    try {
      await _firebaseMessaging.subscribeToTopic(notificationTopic);
      if (kDebugMode) {
        print('Berhasil berlangganan ke topik: $notificationTopic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Gagal berlangganan ke topik: $e');
      }
    }
  }

  Future<void> unsubscribeFromGeneralTopic() async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(notificationTopic);
      if (kDebugMode) {
        print('Berhasil berhenti berlangganan dari topik: $notificationTopic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Gagal berhenti berlangganan dari topik: $e');
      }
    }
  }

  Future<void> syncSubscriptionStatus() async {
    final isEnabled = await PrefsStore.getNotificationStatus();
    if (isEnabled) {
      await subscribeToGeneralTopic();
    } else {
      await unsubscribeFromGeneralTopic();
    }
  }
}
