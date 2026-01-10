import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications/service/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log(token ?? "null");
    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
    handelForegroundMessage();
  }

  static Future<void> handelBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    // TODO: handel log error
    log(message.notification?.title ?? 'null');
  }

  static void handelForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationsService.showBasicNotification(message);
    });
  }
}
