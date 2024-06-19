import 'package:fe_attendance_app/features/main_feature/controllers/checkin/camera_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognitionScreen> {
  late CheckinController controller;
  late MyCameraController cameraController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
    cameraController = Get.put(MyCameraController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Container(
        child: GetBuilder<MyCameraController>(
          builder: (controller) {
            if (controller.cameraController == null ||
                !controller.cameraController!.value.isInitialized) {
              return Center(child: CircularProgressIndicator());
            }
            return controller.cameraController!.buildPreview();
          },
        ),
      )),
    );
  }
}
