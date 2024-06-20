import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';
import 'package:intl/intl.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  Rx<bool> loading = true.obs;
  Rx<bool> flashing = false.obs;
  List<Widget> screen = [BarcodeScannerScreen(), FaceRecognitionScreen()];
  final _auth = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  QueryDocumentSnapshot? documentSnapshot;
  RxBool checkin = false.obs;
  DateTime dateTime = DateTime.now();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    date();
  }

  Future<void> date() async {
    dateTime = await GMT.now() ?? DateTime.now();
  }

  void getClassInfo() async {
    loading.value = true;
    DateTime? now = await GMT.now();
    var querySnapshot = await _firestore
        .collection(_auth!.uid)
        .where('day_of_class', isEqualTo: AppFormatter.formatDateToWeekDay(now))
        .where('start_date',
            isLessThanOrEqualTo: AppFormatter.formatToTimeStamp(now))
        .where('end_date',
            isGreaterThanOrEqualTo: AppFormatter.formatToTimeStamp(now))
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        documentSnapshot = querySnapshot.docs.single;
      }
    }, onError: (e) {
      print('Error Class: ' + e.toString());
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

  void startCheckin() async {
    var query = await _firestore
        .collection(_auth!.uid)
        .doc(documentSnapshot!.id)
        .collection(
            'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print('co');
      } else {
        print('ko');
      }
    }, onError: (error) {
      print("Error when start checkin ${error.message}");
    });
  }
}
