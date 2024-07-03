import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/widgets/pop_up_dialog.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportExcelController extends GetxController {
  static ExportExcelController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // late List<String> option;
  late String selected = '';
  RxBool loading = false.obs;
  bool cancel = false;
  Future<List<String>> getClass() async {
    // DateTime? d = await GMT.now();
    // DateTime dateTime = d!.toLocal();
    // DocumentReference<Map<String, dynamic>> doc =

    var query = await _firestore
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var option = List.generate(query.docs.length, (index) {
      var data = query.docs[index];
      return '${data.id} - ${data.get('name_of_class')}';
    });
    selected = option.first.split('-')[0].removeAllWhitespace;
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
    loading.value = true;
    cancel = false;
    DateTime? d = await GMT.now();
    DateTime dateTime = d!.toLocal();
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var excel = Excel.createExcel();
      var query = _firestore
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(selected);
      var tempt = await query.get();
      int section =
          AppFormatter.numberOfWeek(tempt.get('start_date').toDate(), dateTime);
      for (int i = 1; i <= section; i++) {
        if (cancel) {
          loading.value = false;
          return;
        }
        Sheet sheetCheckin = excel['Buoi_${i}_Checkin'];
        Sheet sheetCheckout = excel['Buoi_${i}_Checkout'];
        sheetCheckin.appendRow([
          const TextCellValue('STT'),
          const TextCellValue('MSSV'),
          const TextCellValue('Thời gian')
        ]);
        sheetCheckout.appendRow([
          const TextCellValue('STT'),
          const TextCellValue('MSSV'),
          const TextCellValue('Thời gian')
        ]);
        await query.collection('buoi_$i').doc('check_in').get().then((value) {
          var data = value.data();
          if (data != null && data.isNotEmpty) {
            for (int i = 0; i < data.length; i++) {
              var dateTime = data.entries.elementAt(i).value.toDate();
              sheetCheckin.appendRow([
                IntCellValue(i + 1),
                TextCellValue(data.entries.elementAt(i).key),
                DateCellValue.fromDateTime(dateTime)
              ]);
            }
          }
        });
        await query.collection('buoi_$i').doc('check_out').get().then((value) {
          var data = value.data();
          if (data != null && data.isNotEmpty) {
            for (int i = 0; i < data.length; i++) {
              var dateTime = data.entries.elementAt(i).value.toDate();
              sheetCheckout.appendRow([
                IntCellValue(i + 1),
                TextCellValue(data.entries.elementAt(i).key),
                DateCellValue.fromDateTime(dateTime)
              ]);
            }
          }
        });
      }
      var fileBytes = excel.encode();
      Uint8List bytes = Uint8List.fromList(fileBytes!);
      final params = SaveFileDialogParams(
        fileName: 'Danh_sach_diem_danh_$selected.xlsx',
        data: bytes,
        mimeTypesFilter: [
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        ],
      );
      final result = await FlutterFileDialog.saveFile(params: params);
      if (result != null) {
        Get.dialog(
          PopUpDialog(
            seconds: 5,
            result: true,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TAnimationLoaderWidget(
                  text: '',
                  animation: AppImages.successfulAnimation,
                  height: THelperFunctions.screenHeight() / 8,
                ),
                Text(
                  'Lưu file điểm danh thành công',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                      fontSize: THelperFunctions.screenWidth() * 0.04),
                ),
                Text(
                  'Tên file: Danh_sach_diem_danh_$selected.xlsx',
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
      } else {
        Get.dialog(
          PopUpDialog(
            seconds: 5,
            result: true,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TAnimationLoaderWidget(
                  text: '',
                  animation: AppImages.docerAnimation,
                  height: THelperFunctions.screenHeight() / 8,
                ),
                Text(
                  'File chưa được lưu',
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
                'Chưa cấp quyền truy cập tệp',
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
    loading.value = false;
  }
}
