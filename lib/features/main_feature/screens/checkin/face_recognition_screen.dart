import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:camera/camera.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognitionScreen> {
  late FaceRecognitionController cameraController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController = Get.put(FaceRecognitionController());
  }

  @override
  Widget build(BuildContext context) {
    cameraController.initializeCamera();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () {
                cameraController.switchCamera();
              },
              icon: Icon(Icons.cameraswitch_rounded),
            ),
            GetBuilder<FaceRecognitionController>(
              builder: (controller) {
                return IconButton(
                  icon: Icon(
                    controller.flashMode == FlashMode.torch
                        ? Icons.flashlight_on_rounded
                        : Icons.flashlight_off_rounded,
                  ),
                  onPressed: () {
                    controller.toggleFlash();
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: ElevatedButton(
            onPressed: () {
              cameraController.sendImageToAPI();
            },
            child: Text('API')),
        body: GetBuilder<FaceRecognitionController>(
          builder: (controller) {
            if (controller.cameraController == null ||
                !controller.cameraController!.value.isInitialized) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                controller.cameraController!.buildPreview(),
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
                      cutOutBottomOffset:
                          MediaQuery.of(context).size.height / 30,
                      overlayColor: const Color.fromRGBO(0, 0, 0, 82),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
