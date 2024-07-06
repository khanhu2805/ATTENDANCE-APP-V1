import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreeen extends StatelessWidget {
  const NotificationScreeen({super.key});

  static const route = '/notification_screen';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
      ),
      body: Center(
        child: Padding( 
          padding: const EdgeInsets.all(20.0),
          // ignore: unnecessary_null_comparison
          child: message != null 
            ?  Text('${message.notification?.title}\n${message.notification?.body}\n${message.data}')
            : const Text("Không có thông báo nào."), 
        ),
      ),
    ),);
  }
}
