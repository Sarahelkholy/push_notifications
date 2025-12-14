import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notifications/app/push_notifications_app.dart';
import 'package:push_notifications/firebase_options.dart';
import 'package:push_notifications/service/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationsService.init();
  runApp(PushNotificationsApp());
}
