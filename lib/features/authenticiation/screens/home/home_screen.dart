import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home/home_controller.dart'; // Import controller

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Chủ'),
      ),
      body: Center(
        child: Obx(() {
          if (_controller.user == null) {
            return const Text('Chưa đăng nhập');
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Xin chào, ${_controller.user!.displayName ?? _controller.user!.email}'),
                ElevatedButton(
                  onPressed: () => _controller.logout(),
                  child: const Text('Đăng xuất'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
