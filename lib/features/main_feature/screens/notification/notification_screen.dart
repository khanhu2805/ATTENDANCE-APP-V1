import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreeen extends StatefulWidget {
  const NotificationScreeen({super.key});

  static const route = '/notification_screen';

  @override
  State<NotificationScreeen> createState() => _NotificationScreeenState();
}

class _NotificationScreeenState extends State<NotificationScreeen> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
    }
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Thông báo")),
      body: Center(
      child: payload.isNotEmpty
            ?  Text(payload.toString())
            : const Text("Không có thông báo nào."), 
        ),
    );
  }
}
