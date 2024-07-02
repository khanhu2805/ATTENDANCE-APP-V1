import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExportExcelController extends GetxController {
  static ExportExcelController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // late List<String> option;
  late String selected = '';
  Future<List<String>> getClass() async {
    // DateTime? d = await GMT.now();
    // DateTime dateTime = d!.toLocal();
    // DocumentReference<Map<String, dynamic>> doc =
        
    var query = await _firestore.collection(FirebaseAuth.instance.currentUser!.uid).get();
    var option = List.generate(query.docs.length, (index) {
      var data = query.docs[index];
      return '${data.id} - ${data.get('name_of_class')}';
    });
    selected = option.first.split('-')[0];
    return option;
    // DocumentSnapshot<Map<String, dynamic>> docu = await doc.get();
    // int section =
    //     AppFormatter.numberOfWeek(docu.get('start_date').toDate(), dateTime);
    // option = List.generate(section, (index) => 'Buổi ${index + 1}');
    // documentReference = doc;
    // selected = 'buoi_${option.last.substring(5, option.last.length)}';
    // return docu;
  }
  Future<void> exportToExcel() async {
    
  }

}