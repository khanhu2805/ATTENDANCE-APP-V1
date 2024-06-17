import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/checkin_screen.dart';
import 'package:flutter/material.dart';

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognitionScreen> {
  late CheckinController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(controller.studentCode.value),
        ),
      ),
    );
  }
}
