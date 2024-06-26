import 'dart:convert';
import 'dart:typed_data';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:gmt/gmt.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';

class FaceRecognitionController extends GetxController {
  static FaceRecognitionController get instance => Get.find();
  CheckinController checkinController = CheckinController.instance;
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;
  FlashMode flashMode = FlashMode.off;
  RxString studentCode = ''.obs;
  RxBool loading = false.obs;

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        selectedCameraIndex = 0;
        await setCamera(selectedCameraIndex);
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> setCamera(int index) async {
    try {
      if (cameraController != null) {
        await cameraController!.dispose();
        cameraController = null;
      }

      if (cameras != null && cameras!.isNotEmpty) {
        cameraController = CameraController(
          cameras![index],
          ResolutionPreset.max,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );

        await cameraController!.initialize();
        update();
      }
    } catch (e) {
      print('Error setting camera: $e');
    }
  }

  Future<void> updateFlashMode(FlashMode mode) async {
    try {
      await cameraController?.setFlashMode(mode);
      flashMode = mode;
      update();
    } catch (e) {
      print('Error setting flash mode: $e');
    }
  }

  void switchCamera() async {
    if (cameras != null && cameras!.isNotEmpty) {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
      await setCamera(selectedCameraIndex);
    }
  }

  void toggleFlash() {
    if (flashMode == FlashMode.off) {
      updateFlashMode(FlashMode.torch);
    } else {
      updateFlashMode(FlashMode.off);
    }
  }

  Future<String> captureImage() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      try {
        XFile picture = await cameraController!.takePicture();
        Uint8List imageData = await picture.readAsBytes();
        img.Image image = img.decodeImage(imageData.buffer.asUint8List())!;

        int targetWidth = (image.height / 4).round();
        int targetHeight = (image.height / 4).round();

        int startX = (image.width - targetWidth) ~/ 2;
        int startY = (image.height - targetHeight) ~/ 2;
        img.Image croppedImage = img.copyCrop(image,
            x: startX, y: startY, width: targetWidth, height: targetHeight);
        return base64Encode(img.encodeJpg(croppedImage));
      } catch (e) {
        print('Error capturing and sending image: $e');
      }
    }
    return '';
  }

  Future<void> sendImageToAPI() async {
    DateTime? d = await GMT.now();
    DateTime now = d!.toLocal();
    loading.value = true;
    const String apiUrl =
        'https://121c-118-69-55-70.ngrok-free.app'; // Replace with your API URL
    int attempt = 0;

    while (attempt < 3) {
      try {
        String base64Image = await captureImage();
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'image': base64Image}),
        );

        if (response.statusCode == 200) {
          print('Image sent successfully');
          if (response.body != 'Khong nhan dien duoc') {
            studentCode.value = response.body;
            if (checkinController.studentCode.value == studentCode.value) {
              checkinController.documentReference
                  ?.update({studentCode.value: now});
              checkinController.screenIndex.value = 0;
            }
            loading.value = false;
            return;
          } // Exit the function if successful
        } else {
          print('Failed to send image: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending image to API: $e');
      }

      attempt++;
      await Future.delayed(const Duration(seconds: 3)); // Wait before retrying
    }
    studentCode.value = 'Không nhận diện được';
    loading.value = false;
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
