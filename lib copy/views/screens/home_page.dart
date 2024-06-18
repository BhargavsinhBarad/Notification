import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_demo_app/utils/helpers/FCMHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_demo_app/utils/helpers/LPNHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getFCM() async {
    String? token = await FCMHelper.fcmHelper.getDeviceToken();

    print("TOKEN: $token");
  }

  @override
  void initState() {
    super.initState();
    getFCM();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    LPNHelper.flutterLocalNotificationsPlugin
        .initialize(initializationSettings);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await LPNHelper.lpnHelper.sendSimpleLocalNotification(
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This is HomePage"),
            OutlinedButton(
              child: const Text("Send FCM"),
              onPressed: () async {
                await FCMHelper.fcmHelper.sendFCMByAPI();
              },
            ),
            OutlinedButton(
              child: const Text("Subscribe 'sports'"),
              onPressed: () async {
                await FCMHelper.fcmHelper.subscribeToTopic(topic: 'sports');
              },
            ),
            OutlinedButton(
              child: const Text("Unsubscribe 'sports'"),
              onPressed: () async {
                await FCMHelper.fcmHelper.unsubscribeFromTopic(topic: 'sports');
              },
            ),
          ],
        ),
      ),
    );
  }
}
