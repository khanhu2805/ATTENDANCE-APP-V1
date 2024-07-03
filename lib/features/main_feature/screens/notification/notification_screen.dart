import 'package:flutter/material.dart';

class NotificationScreeen extends StatelessWidget {
  const NotificationScreeen({super.key});

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Text('Thông báo'),
      ),
    ));
  }
}
