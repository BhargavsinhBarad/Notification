import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FCMHelper {
  FCMHelper._();
  static final FCMHelper fcmHelper = FCMHelper._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    return token;
  }

  Future<void> sendFCMByAPI() async {
    Map<String, dynamic> myBody = {
      // "to": "TOKEN",
      // "topic": "topics/sports",
      "register_ids": ["TOKEN1", "TOKEN"],
      "notification": {
        "content_available": true,
        "priority": "high",
        "title": "Tushal",
        "body": "Gopani"
      },
      "data": {
        "priority": "high",
        "content_available": true,
        "school": "RNW",
        "age": "19"
      }
    };

    Map<String, String> myHeaders = {
      "Content-Type": "application/json",
      "Authorization": "key=YOUR_SERVER_KEY",
    };

    http.Response res = await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      body: jsonEncode(myBody),
      headers: myHeaders,
    );

    Logger().i("${res.statusCode}");

    if (res.statusCode == 200) {
      Logger().i("${res.body}");
    } else {
      Logger().i("${res.body}");
    }
  }

  Future<void> subscribeToTopic({required String topic}) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic({required String topic}) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
