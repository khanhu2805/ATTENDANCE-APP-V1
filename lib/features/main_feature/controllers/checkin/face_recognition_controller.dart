import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/widgets/pop_up_dialog.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:gmt/gmt.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class FaceRecognitionController extends GetxController {
  static FaceRecognitionController get instance => Get.find();
  CheckinController checkinController = CheckinController.instance;
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  RxBool loading = false.obs;

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        await setCamera(checkinController.facing ? 1 : 0);
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> setCamera(int index) async {
    try {
      loading.value = true;
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
        await cameraController?.setFlashMode(
            checkinController.flashing.value ? FlashMode.torch : FlashMode.off);
        loading.value = false;
      }
    } catch (e) {
      print('Error setting camera: $e');
      loading.value = false;
    }
  }

  Future<void> updateFlashMode(FlashMode mode) async {
    try {
      await cameraController?.setFlashMode(mode);
    } catch (e) {
      print('Error setting flash mode: $e');
    }
  }

  void switchCamera() async {
    if (cameras != null && cameras!.isNotEmpty) {
      await setCamera(checkinController.facing ? 0 : 1);
      checkinController.facing = !checkinController.facing;
    }
  }

  void toggleFlash() {
    if (!checkinController.facing) {
      updateFlashMode(
          checkinController.flashing.value ? FlashMode.off : FlashMode.torch);
      checkinController.flashing.value = !checkinController.flashing.value;
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
    const String apiUrl = 'http://huflit.drayddns.com:81/';
    int attempt = 0;

    while (attempt < 3) {
      try {
        String base64Image = await captureImage();
        final ioc = HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = IOClient(ioc);
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'student_code': checkinController.studentCode.value,
            'image': base64Image
          }),
        );
        if (response.statusCode == 200) {
          print('Image sent successfully');
          if (response.body != 'Khong nhan dien duoc') {
            if (checkinController.studentCode.value == response.body) {
              checkinController.documentReference?.update({response.body: now});
              checkinController.screenIndex.value = 0;
              Get.dialog(
                PopUpDialog(
                  seconds: 5,
                  result: true,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TAnimationLoaderWidget(
                        text: '',
                        animation: AppImages.successfulAnimation,
                        height: THelperFunctions.screenHeight() / 8,
                      ),
                      Text(
                        'Điểm danh thành công',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                            fontSize: THelperFunctions.screenWidth() * 0.04),
                      ),
                      Text(
                        'MSSV: ${response.body}',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                            fontSize: THelperFunctions.screenWidth() * 0.04),
                      )
                    ],
                  ),
                ),
                transitionDuration: const Duration(milliseconds: 200),
                barrierDismissible: false,
              );
              return;
            } else {
              print(response.body);
            }
          }
        } else {
          Get.dialog(
            PopUpDialog(
              seconds: 5,
              result: false,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TAnimationLoaderWidget(
                    text: '',
                    animation: AppImages.failAnimation,
                    height: THelperFunctions.screenHeight() / 8,
                  ),
                  Text(
                    'Lỗi API',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                        fontSize: THelperFunctions.screenWidth() * 0.04),
                  ),
                ],
              ),
            ),
            transitionDuration: const Duration(milliseconds: 200),
            barrierDismissible: false,
          );

          return;
        }
      } catch (e) {
        Get.dialog(
          PopUpDialog(
            seconds: 5,
            result: false,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TAnimationLoaderWidget(
                  text: '',
                  animation: AppImages.failAnimation,
                  height: THelperFunctions.screenHeight() / 8,
                ),
                Text(
                  'Lỗi API',
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                      fontSize: THelperFunctions.screenWidth() * 0.04),
                ),
              ],
            ),
          ),
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: false,
        );
        return;
      }
      attempt++;
      await Future.delayed(const Duration(seconds: 1));
    }
    Get.dialog(
      PopUpDialog(
        seconds: 5,
        result: false,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TAnimationLoaderWidget(
              text: '',
              animation: AppImages.failAnimation,
              height: THelperFunctions.screenHeight() / 8,
            ),
            Text(
              'Chưa nhận diện được gương mặt',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                  fontSize: THelperFunctions.screenWidth() * 0.04),
            ),
            Text(
              'Vui lòng đưa gương mặt vào đúng ô quy định',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                  fontSize: THelperFunctions.screenWidth() * 0.04),
            ),
          ],
        ),
      ),
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: false,
    );
  }

  void disposeCamera() {
    cameraController?.dispose();
    cameraController = null;
  }

  @override
  void onClose() {
    disposeCamera();
    super.onClose();
  }
}
