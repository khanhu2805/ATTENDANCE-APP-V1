import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/compare_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  Rx<bool> flashing = false.obs;
  List<Widget> screen = [const BarcodeScannerScreen(), const FaceRecognitionScreen()];
  final _auth = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool checkin = false;
  DateTime dateTime = DateTime.now();
  DocumentReference? documentReference;
  QueryDocumentSnapshot<Map<String, dynamic>>? documentSnapshot;

  Stream<QueryDocumentSnapshot<Map<String, dynamic>>?> getClassInfo() async* {
    DateTime? d = await GMT.now();
    dateTime = d!.toLocal();
    QueryDocumentSnapshot<Map<String, dynamic>>? query;
    var querySnapshot = await _firestore
        .collection(_auth!.uid)
        .where('day_of_class',
            isEqualTo: AppFormatter.formatDateToWeekDay(dateTime))
        .where('start_date',
            isLessThanOrEqualTo: AppFormatter.formatToTimeStamp(dateTime))
        .where('end_date',
            isGreaterThanOrEqualTo: AppFormatter.formatToTimeStamp(dateTime))
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          if (((dateTime.hour * 60 + dateTime.minute) -
                      AppFormatter.formatStringToTime(doc.get('start_hour'))) <=
                  15 &&
              ((dateTime.hour * 60 + dateTime.minute) -
                      AppFormatter.formatStringToTime(doc.get('start_hour'))) >=
                  0) {
            checkin = true;
            documentSnapshot = doc;
            query = doc;
          } else if ((AppFormatter.formatStringToTime(doc.get('end_hour')) -
                      (dateTime.hour * 60 + dateTime.minute)) <=
                  15 &&
              (AppFormatter.formatStringToTime(doc.get('end_hour')) -
                      (dateTime.hour * 60 + dateTime.minute)) >=
                  0) {
            checkin = false;
            documentSnapshot = doc;
            query = doc;
          }
        }
      }
    }, onError: (e) {
      print('Error Class: ' + e.toString());
    });
    yield query;
  }

  void checkStudentCode(String barcode) {
    List<dynamic> studentList = documentSnapshot!.get('students');
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
        if (checkin) {
          documentReference = _firestore
              .collection(_auth.uid)
              .doc(documentSnapshot!.id)
              .collection(
                  'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
              .doc('check_in');
        } else {
          documentReference = _firestore
              .collection(_auth.uid)
              .doc(documentSnapshot!.id)
              .collection(
                  'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
              .doc('check_out');
        }
      } else {
        _firestore
            .collection(_auth.uid)
            .doc(documentSnapshot!.id)
            .collection(
                'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
            .doc('check_in')
            .set({});
        _firestore
            .collection(_auth.uid)
            .doc(documentSnapshot!.id)
            .collection(
                'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
            .doc('check_out')
            .set({});
      }
    }, onError: (error) {
      print("Error when start checkin ${error.message}");
    });
    Get.to(() => const CompareScreen());
  }
}
