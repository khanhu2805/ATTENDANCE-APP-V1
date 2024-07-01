import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:camera/camera.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognitionScreen> {
  late FaceRecognitionController faceRecognitionController;

  @override
  void initState() {
    super.initState();
    faceRecognitionController = Get.put(FaceRecognitionController(), permanent: true);
    faceRecognitionController.initializeCamera();
  }

  @override
  void dispose() {
    faceRecognitionController.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                faceRecognitionController.switchCamera();
              },
              icon: const Icon(Icons.cameraswitch_rounded),
            ),
            Obx(() {
              return IconButton(
                icon: Icon(
                  CheckinController.instance.flashing.value
                      ? Icons.flashlight_on_rounded
                      : Icons.flashlight_off_rounded,
                ),
                onPressed: () {
                  faceRecognitionController.toggleFlash();
                },
              );
            }),
          ],
        ),
        body: Obx(() {
          if (faceRecognitionController.loading.value ||
              faceRecognitionController.cameraController == null ||
              !faceRecognitionController.cameraController!.value.isInitialized) {
            return Center(child: AppLoaders.showCircularLoader());
          }
          return Stack(
            children: [
              if (faceRecognitionController.cameraController != null &&
                  faceRecognitionController.cameraController!.value.isInitialized)
                faceRecognitionController.cameraController!.buildPreview(),
              Container(
                decoration: ShapeDecoration(
                  shape: OverlayShape(
                    borderRadius: 24,
                    borderColor: Colors.white,
                    borderLength: 42,
                    borderWidth: 12,
                    cutOutSize: 0.0,
                    cutOutHeight: MediaQuery.of(context).size.height / 4,
                    cutOutWidth: MediaQuery.of(context).size.height / 4,
                    cutOutBottomOffset: MediaQuery.of(context).size.height / 30,
                    overlayColor: const Color.fromRGBO(0, 0, 0, 82),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
