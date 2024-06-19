import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:camera/camera.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/camera_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
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
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                cameraController.switchCamera();
              },
              icon: Icon(
                Icons.cameraswitch_rounded,
              )),
          IconButton(
              icon: Obx(() {
                return Icon(cameraController.flashMode.value == FlashMode.torch
                    ? Icons.flash_on_rounded
                    : Icons.flash_off_rounded);
              }),
              onPressed: () => {cameraController.toggleFlash()}),
        ],
      ),
      body: Container(
        child: Obx(() {
          if (cameraController.cameraController.value == null ||
              !cameraController.cameraController.value!.value.isInitialized) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(children: [
            cameraController.cameraController.value!.buildPreview(),
            Container(
              decoration: ShapeDecoration(
                shape: OverlayShape(
                  borderRadius: 24,
                  borderColor: Colors.white,
                  borderLength: 42,
                  borderWidth: 12,
                  cutOutSize: 0.0,
                  cutOutHeight: THelperFunctions.screenHeight() / 4,
                  cutOutWidth: THelperFunctions.screenHeight() / 4,
                  cutOutBottomOffset: THelperFunctions.screenHeight() / 30,
                  overlayColor: const Color.fromRGBO(0, 0, 0, 82),
                ),
              ),
            )
          ]);
        }),
      ),
    ));
  }
}
