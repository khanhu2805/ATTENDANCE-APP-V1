import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class LogController extends GetxController {
  static LogController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<String> option = [''].obs;
  String selected = 'buoi_1';
  String check = 'check_out';
  late DocumentReference<Map<String, dynamic>> documentReference;
  final StreamController<Map<String, dynamic>?> logStreamController =
      StreamController<Map<String, dynamic>?>();
  Future<DocumentSnapshot<Map<String, dynamic>>> getClassInfo(String id) async {
    DateTime? d = await GMT.now();
    DateTime dateTime = d!.toLocal();
    DocumentReference<Map<String, dynamic>> doc =
        _firestore.collection(FirebaseAuth.instance.currentUser!.uid).doc(id);
    DocumentSnapshot<Map<String, dynamic>> docu = await doc.get();
    int section =
        AppFormatter.numberOfWeek(docu.get('start_date').toDate(), dateTime);
    option.value = List.generate(section, (index) => 'buoi_${index + 1}');
    documentReference = doc;
    return docu;
  }

  Future<void> getLog() async {
    await documentReference
        .collection(selected)
        .doc(check)
        .get()
        .then((value) => logStreamController.add(value.data()));
  }
  Stream<Map<String, dynamic>?> get logStream => logStreamController.stream;
}
