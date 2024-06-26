import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt selectedDate = 0.obs;
  Rx<DateTime> now = DateTime(0, 0, 0).obs;

  void getDate() async {
    DateTime? d = await GMT.now();
    now.value = d!.toLocal();
    selectedDate.value = now.value.day - 1;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>?> getClass(
      int selectedIndex) async* {
    DateTime? d = await GMT.now();
    DateTime now = d!.toLocal();
    yield await firestore
        .collection(auth.currentUser!.uid)
        .where('day_of_class',
            isEqualTo: AppFormatter.formatDateToWeekDay(
                DateTime(now.year, now.month, selectedIndex + 1)))
        .where('start_date',
            isLessThanOrEqualTo: AppFormatter.formatToTimeStamp(
                DateTime(now.year, now.month, selectedIndex + 1)))
        .where('end_date',
            isGreaterThanOrEqualTo: AppFormatter.formatToTimeStamp(
                DateTime(now.year, now.month, selectedIndex + 1)))
        .get();
  }
}
