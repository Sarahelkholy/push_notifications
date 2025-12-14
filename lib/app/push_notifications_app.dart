import 'package:flutter/material.dart';

class PushNotificationsApp extends StatelessWidget {
  const PushNotificationsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Push Notifications App',
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text('Push Notifications App')),
        body: const Center(child: Text('Welcome to Push Notifications App!')),
      ),
    );
  }
}
