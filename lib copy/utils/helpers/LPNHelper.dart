import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LPNHelper {
  LPNHelper._();
  static final LPNHelper lpnHelper = LPNHelper._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // TODO: simple notification
  Future<void> sendSimpleLocalNotification(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "Simple Notification",
            priority: Priority.max, importance: Importance.max);
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails,
        payload: "This is my payload");
  }

  // TODO: scheduled notification
  // TODO: big picture notification
  // TODO: media style notification
}
