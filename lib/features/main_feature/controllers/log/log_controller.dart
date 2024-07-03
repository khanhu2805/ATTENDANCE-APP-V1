import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';

class LogController extends GetxController {
  static LogController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<String> option;
  late String selected;
  String check = 'check_in';
  late DocumentReference<Map<String, dynamic>> documentReference;
  final StreamController<Map<String, dynamic>?> logStreamController =
      StreamController<Map<String, dynamic>?>.broadcast();
  Future<DocumentSnapshot<Map<String, dynamic>>> getClassInfo(String id) async {
    DateTime? d = await GMT.now();
    DateTime dateTime = d!.toLocal();
    DocumentReference<Map<String, dynamic>> doc =
        _firestore.collection(FirebaseAuth.instance.currentUser!.uid).doc(id);
    DocumentSnapshot<Map<String, dynamic>> docu = await doc.get();
    int section =
        AppFormatter.numberOfWeek(docu.get('start_date').toDate(), dateTime);
    option = List.generate(section, (index) => 'Buổi ${index + 1}');
    documentReference = doc;
    selected = 'buoi_${option.last.substring(5, option.last.length)}';
    return docu;
  }

  Future<void> getLog() async {
    await documentReference.collection(selected).doc(check).get().then((value) {
      if (value.exists) {
        logStreamController.add(value.data());
      } else {
        logStreamController.add({});
      }
    });
  }

  Stream<Map<String, dynamic>?> get logStream => logStreamController.stream;
}
