import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  String info = '';
  Rx<bool> loading = true.obs;
  List<Widget> screen = [BarcodeScannerScreen(), FaceRecognitionScreen()];
  final _auth = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<bool> check = false.obs;

  void getClassInfo() async {
    loading.value =true;
    var querySnapshot = await _firestore.collection(_auth!.uid).where('day_of_class', isEqualTo: 'Moesday').get();
    if (querySnapshot.docs.isNotEmpty) {
      info = 'Ca điểm danh\nMã lớp học phần: ${querySnapshot.docs.single.id}\nNgày: 16/06/2024 - Buổi 1';
    }
    loading.value = false;
  }

  void checkStudentCode(String barcode) async {
    var querySnapshot = await _firestore
        .collection(_auth!.uid)
        .doc('233121011202')
        .get();
    if (querySnapshot.exists) {
      List<dynamic> studentList = querySnapshot.data()?['student'];
      if (studentList.contains(barcode)) {
        studentCode.value = barcode;
        check.value = true;
        screenIndex.value = 1;
      }
    }
  }
}
