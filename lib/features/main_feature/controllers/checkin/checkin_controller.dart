import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  List<Widget> screen = [BarcodeScannerScreen(), FaceRecognitionScreen()];
  // void scanBarcode(BuildContext context) async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AiBarcodeScanner(
  //           onDetect: (p0) {
  //             String barcode = p0.barcodes.first.rawValue.toString();
  //             studentCode.value = barcode;
  //             Get.to(() => CompareScreen());
  //           },
  //         ),
  //       ));
  // }
}