import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.blue[200],
              child: const Column(
                children: [
                  Text('Xin chào')
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
