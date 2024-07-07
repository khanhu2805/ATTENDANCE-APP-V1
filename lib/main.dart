import 'dart:convert';
import 'package:fe_attendance_app/features/main_feature/screens/notification/push_notifications.dart';
import 'package:fe_attendance_app/utils/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

final navigationKey = GlobalKey<NavigatorState>();
  List<Map<String, dynamic>> notifications = [];

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    if (kDebugMode) {
      print("Some notification Received");
    }
  }
}
Future<void> _saveNotification(
      String title, String body, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    notifications.add({'title': title, 'body': body, 'time': time.toString()});
    await prefs.setStringList(
        'notifications', notifications.map((e) => jsonEncode(e)).toList());
  }

void showNotification({required String title, required String body}) {
  showDialog(
    context: navigationKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    ),
  );
}

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  if (!rememberMe) {
    await AuthenticationRepository.instance.logout();
  }



  //Notification
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      if (kDebugMode) {
        print("Background Notification Tapped");
      }
      navigationKey.currentState!.pushNamed("/notification_screen", arguments: message);
      
    }
  });

  PushNotifications.init();
  if (!kIsWeb) {
    PushNotifications.localNotiInit();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (kDebugMode) {
      print("Got a message in foreground");
    }
    if (message.notification != null) {
      if (kIsWeb) {
        showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      } else {
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
      if (message.notification != null) {
        _saveNotification(
            message.notification?.title ?? '', message.notification?.body ?? '', DateTime.now());
    } 
    }
  });

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    if (kDebugMode) {
      print("Launched from terminated state");
    }
    Future.delayed(const Duration(seconds: 500), () {
      navigationKey.currentState!.pushNamed("/notification_screen", arguments: message);
    });
  }

  runApp(const App());
}
