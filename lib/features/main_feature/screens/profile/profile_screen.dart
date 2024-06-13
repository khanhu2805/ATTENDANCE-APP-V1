import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: MaterialButton(
            onPressed: () {_controller.logout();},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            color: Colors.blue[200],
            child: const Text(
              'Đăng xuất',
            ),
          ),
        ),
      ),
    );
  }
}
