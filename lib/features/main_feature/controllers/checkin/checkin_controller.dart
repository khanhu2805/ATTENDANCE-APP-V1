import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/main.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  Rx<bool> loading = true.obs;
  List<Widget> screen = [BarcodeScannerScreen(), FaceRecognitionScreen()];
  final _auth = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QueryDocumentSnapshot? documentSnapshot;

  void getClassInfo() async {
    loading.value = true;
    var querySnapshot = await _firestore
        .collection(_auth!.uid)
        .where('day_of_class',
            isEqualTo: AppFormatter.formatDateToWeekDay(null))
        .where('start_date', isLessThanOrEqualTo: Timestamp.now())
        .where('end_date', isGreaterThanOrEqualTo: Timestamp.now())
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        documentSnapshot = querySnapshot.docs.single;
      }
    }, onError: (e) {
      print('Error Class: ' + e);
    });
    loading.value = false;
  }

  void checkStudentCode(String barcode) {
    List<dynamic> studentList = documentSnapshot!.get('student');
    if (studentList.contains(barcode)) {
      studentCode.value = barcode;
      screenIndex.value = 1;
    } else {
      studentCode.value = '0';
    }
  }

}
