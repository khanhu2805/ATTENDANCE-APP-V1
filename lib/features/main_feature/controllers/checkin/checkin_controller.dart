import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/compare_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/widgets/pop_up_dialog.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class CheckinController extends GetxController {
  static CheckinController get instance => Get.find();

  Rx<String> studentCode = ''.obs;
  Rx<int> screenIndex = 0.obs;
  Rx<bool> flashing = false.obs;
  bool facing = true;
  List<Widget> screen = [
    const BarcodeScannerScreen(),
    const FaceRecognitionScreen()
  ];
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

  Future<void> checkStudentCode(String barcode) async {
    List<dynamic> studentList = documentSnapshot!.get('students');
    if (studentList.contains(barcode)) {
      studentCode.value = barcode;
      screenIndex.value = 1;
      await Get.dialog(
        PopUpDialog(
          seconds: 5,
          result: true,
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.onBoardingImage1),
              Text(
                'Vui lòng đưa gương mặt vào ô quy định và đảm bảo về ánh sáng',
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
      // await Future.delayed(const Duration(seconds: 3));
      await FaceRecognitionController.instance.sendImageToAPI();
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
                'Sinh viên không có trong danh sách',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                    fontSize: THelperFunctions.screenWidth() * 0.04),
              ),
              Text(
                'Vui lòng thử lại',
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
  }

  void startCheckin() async {
    var query = await _firestore
        .collection(_auth!.uid)
        .doc(documentSnapshot!.id)
        .collection(
            'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        await _firestore
            .collection(_auth.uid)
            .doc(documentSnapshot!.id)
            .collection(
                'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
            .doc('check_in')
            .set({});
        await _firestore
            .collection(_auth.uid)
            .doc(documentSnapshot!.id)
            .collection(
                'buoi_${AppFormatter.numberOfWeek(documentSnapshot!.get('start_date').toDate(), dateTime)}')
            .doc('check_out')
            .set({});
      }
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
    }, onError: (error) {
      print("Error when start checkin ${error.message}");
    });
    Get.to(() => const CompareScreen());
  }
}
