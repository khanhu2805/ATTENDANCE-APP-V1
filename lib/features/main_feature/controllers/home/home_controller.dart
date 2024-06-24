import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>?> getClass() async {
    DateTime? d = await GMT.now();
    DateTime dateTime = d!.toLocal();
    return await firestore
        .collection(auth.currentUser!.uid)
        .where('day_of_class',
            isEqualTo: AppFormatter.formatDateToWeekDay(dateTime))
        .where('start_date',
            isLessThanOrEqualTo: AppFormatter.formatToTimeStamp(dateTime))
        .where('end_date',
            isGreaterThanOrEqualTo: AppFormatter.formatToTimeStamp(dateTime))
        .get();
  }
}
