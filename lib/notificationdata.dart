import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDataServices extends StatefulWidget {
  const NotificationDataServices({super.key});

  @override
  State<NotificationDataServices> createState() =>
      _NotificationDataServicesState();
}

class _NotificationDataServicesState extends State<NotificationDataServices> {
  @override
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    // for background or terminated state
    if (data is RemoteMessage) {
      payload = data.data;
    }
    // for forground state

    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Center(
        child: Text(payload.toString()),
      ),
    );
  }
}
