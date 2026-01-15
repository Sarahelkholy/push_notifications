import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> notificationsStream =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    notificationsStream.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  /// basic notifications
  static void showBasicNotification(RemoteMessage message) async {
    // download image from url
    final http.Response image = await http.get(
      Uri.parse(message.notification?.android?.imageUrl ?? ''),
    );
    // set big picture style
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(image.bodyBytes),
          ),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(image.bodyBytes),
          ),
        );

    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'id1',
        'Basic Notifications',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: bigPictureStyleInformation,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
}
