import 'dart:convert';

import 'package:color_game/backend/game/controller/user_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging fmsg = FirebaseMessaging.instance;

  static init() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
// to handle forground state
      if (msg.notification != null) {
        shownotification(
          msg.notification!.title!,
          msg.notification!.body!,
        );
      }
    });
  }

// function to listion background changes

  static Future _firebaseBackgroundMessage(RemoteMessage msg) async {
    if (msg.notification != null) {
      if (kDebugMode) {
        print("Some notification Recived in background");
      }
    }
  }

  Future<void> requestPermision(BuildContext context) async {
    var userController = Provider.of<UserController>(context, listen: false);
    await fmsg.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    PermissionStatus status = await Permission.notification.status;
    if (status != PermissionStatus.denied &&
        status != PermissionStatus.permanentlyDenied) {
      await fmsg.getToken().then((value) {
        if (userController.currentuser!.fcmToken.isNotEmptyAndNotNull) {
          if (userController.currentuser!.fcmToken != value) {
            userController.updateFcmToken(value!);
          }
        } else {
          userController.updateFcmToken(value!);
        }
        fmsg.onTokenRefresh.listen((event) {
          userController.updateFcmToken(event);
        });
      });
    } else {}
  }

  // on tap local notification in forground

  static void onNotificationTap(NotificationResponse response) {
    // navigatorkey.currentState!.pushNamed("/menu", arguments: response);
  }

// show a simple notification

  static Future shownotification(
    String title,
    body,
  ) async {
    AndroidNotificationDetails details = const AndroidNotificationDetails(
      "basic",
      "basic",
      importance: Importance.max,
      priority: Priority.max,
      ticker: "ticker",
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: details);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static sendFCM(String title, String body, String fcmToken) async {
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAc_XIQU4:APA91bHDzIgaXGiatnorWCcHjj3Dnu6dpJdFftjzzFjjOh18kPIyfbqSkyemGERNWY29bzEdKfzFjM8KKTIszae1pR3W1gR2F9cG7-FC31GMLG0nOYPcWd11paWjHO0njsPZWufO5_bO"
        },
        body: jsonEncode(<String, dynamic>{
          "priority": "high",
          "data": {
            "body": body,
            "title": title,
          },
          "to": fcmToken,
          "notification": {
            "body": body,
            "title": title,
            "android_channel_id": "basic"
          }
        }));
  }
}
