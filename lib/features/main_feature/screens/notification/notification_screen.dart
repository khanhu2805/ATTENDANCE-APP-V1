import 'package:flutter/material.dart';

class NotificationScreeen extends StatelessWidget {
  const NotificationScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Text('Thông báo'),
      ),
    ));
  }
}
