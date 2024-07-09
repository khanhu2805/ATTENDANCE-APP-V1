import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:excel/excel.dart' as Excel;
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

  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    bool havePermission;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await info.androidInfo;
      debugPrint('releaseVersion : ${androidInfo.version.release}');
      final int androidVersion = int.parse(androidInfo.version.release);
      havePermission = false;

      if (androidVersion >= 13) {
        final request = await [
          // Permission.videos,
          // Permission.photos,
          Permission.manageExternalStorage,
        ].request();
        havePermission = request.values
            .every((status) => status == PermissionStatus.granted);
      } else {
        final status = await Permission.storage.request();
        havePermission = status.isGranted;
      }

      if (!havePermission) {
        // if no permission then open app-setting
        await openAppSettings();
      }
    } else {
      havePermission = true;
    }

    return havePermission;
  }

  Future<void> exportToExcel() async {
    loading.value = true;
    cancel = false;
    DateTime? d = await GMT.now();
    DateTime dateTime = d!.toLocal();
    var status = await storagePermission();
    List<String> studentCodeLs = [];
    if (status) {
      var excel = Excel.Excel.createExcel();
      excel.rename('Sheet1', 'Tổng kết');
      Excel.Sheet sheetTotal = excel['Tổng kết'];
      sheetTotal.merge(Excel.CellIndex.indexByString('A1'),
          Excel.CellIndex.indexByString('F1'));
      Excel.CellStyle cellHeaderStyle = Excel.CellStyle(
        bold: true,
        verticalAlign: Excel.VerticalAlign.Center,
        horizontalAlign: Excel.HorizontalAlign.Center,
        bottomBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        topBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        leftBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        rightBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
      );
      Excel.CellStyle cellCheckStyle = Excel.CellStyle(
        verticalAlign: Excel.VerticalAlign.Center,
        horizontalAlign: Excel.HorizontalAlign.Center,
        bottomBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        topBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        leftBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        rightBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
      );
      Excel.CellStyle cellDateBorderStyle = Excel.CellStyle(
        numberFormat: const Excel.CustomDateTimeNumFormat(
            formatCode: 'dd-MM-yyyy HH:mm:ss'),
        bottomBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        topBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        leftBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        rightBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
      );
      Excel.CellStyle cellBorderStyle = Excel.CellStyle(
        bottomBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        topBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        leftBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
        rightBorder: Excel.Border(borderStyle: Excel.BorderStyle.Thin),
      );
      List<String> headers = [
        'STT',
        'Mã SV',
        'Họ và tên đệm',
        'Tên',
        'Ngày sinh',
        'Giới tính'
      ];
      for (int i = 0; i < headers.length; i++) {
        var cell = sheetTotal.cell(
            Excel.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 1));
        cell.value = Excel.TextCellValue(headers[i]);
        cell.cellStyle = cellHeaderStyle;
      }
      sheetTotal.setColumnWidth(1, 21);
      sheetTotal.setColumnWidth(2, 21);
      sheetTotal.setColumnWidth(3, 21);
      sheetTotal.setColumnWidth(4, 21);
      sheetTotal.setColumnWidth(5, 15);
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
        sheetTotal.setColumnWidth(sheetTotal.maxColumns, 15);
        var cell = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
            columnIndex: sheetTotal.maxColumns, rowIndex: 0));
        cell.value = Excel.TextCellValue('Buổi $i');
        cell.cellStyle = cellHeaderStyle;
        var cell_1 = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
            columnIndex: sheetTotal.maxColumns - 1, rowIndex: 1));
        DateTime date = tempt.get('start_date').toDate();
        cell_1.value = Excel.TextCellValue(
            AppFormatter.formatDate(date.add(Duration(days: 7 * (i - 1)))));
        cell_1.cellStyle = cellHeaderStyle;
        Excel.Sheet sheetCheck = excel['Buổi $i'];
        List<String> checkHeaders = ['STT', 'Mã SV', 'Check-in', 'Check-out'];
        for (int j = 0; j < checkHeaders.length; j++) {
          var cell = sheetCheck.cell(
              Excel.CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 0));
          cell.value = Excel.TextCellValue(checkHeaders[j]);
          cell.cellStyle = cellHeaderStyle;
        }
        sheetCheck.setColumnWidth(1, 21);
        sheetCheck.setColumnWidth(2, 21);
        sheetCheck.setColumnWidth(3, 21);
        await query
            .collection('buoi_$i')
            .doc('check_in')
            .get()
            .then((value) async {
          var data = value.data();
          if (data != null && data.isNotEmpty) {
            for (int l = 0; l < data.length; l++) {
              var studentCode = data.entries.elementAt(l).key;
              var dateTime = data.entries.elementAt(l).value.toDate();
              sheetCheck.appendRow([
                Excel.IntCellValue(l + 1),
                Excel.TextCellValue(data.entries.elementAt(l).key),
                Excel.DateTimeCellValue.fromDateTime(dateTime),
              ]);
              if (!studentCodeLs.contains(studentCode)) {
                studentCodeLs.add(studentCode);
                sheetTotal.appendRow([
                  Excel.IntCellValue(studentCodeLs.length),
                  Excel.TextCellValue(studentCode)
                ]);
                // var cell = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
                //     columnIndex: 0, rowIndex: sheetTotal.maxRows - 1));
                // cell.cellStyle = cellBorderStyle;
                // cell.value = Excel.IntCellValue(studentCodeLs.length);
                // var cell_1 = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
                //     columnIndex: 0, rowIndex: sheetTotal.maxRows - 1));
                // cell_1.cellStyle = cellBorderStyle;
                // cell_1.value = Excel.TextCellValue(studentCode);
              }
              await query
                  .collection('buoi_$i')
                  .doc('check_out')
                  .get()
                  .then((value) {
                if (value.data()!.containsKey(studentCode)) {
                  var cell = sheetCheck.cell(
                      Excel.CellIndex.indexByString('D${sheetCheck.maxRows}'));
                  cell.value = Excel.DateTimeCellValue.fromDateTime(
                      value.get(studentCode).toDate());
                }
              });
            }
          }
        });
        for (int rowIndex = 1; rowIndex < sheetCheck.maxRows; rowIndex++) {
          for (int columnIndex = 0;
              columnIndex < sheetCheck.maxColumns;
              columnIndex++) {
            var cell = sheetCheck.cell(Excel.CellIndex.indexByColumnRow(
                columnIndex: columnIndex, rowIndex: rowIndex));
            if (columnIndex < 2) {
              cell.cellStyle = cellBorderStyle;
            } else {
              cell.cellStyle = cellDateBorderStyle;
            }
          }
        }
      }
      for (int rowIndex = 2; rowIndex < sheetTotal.maxRows; rowIndex++) {
        for (int columnIndex = 0;
            columnIndex < sheetTotal.maxColumns;
            columnIndex++) {
          var cell = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
              columnIndex: columnIndex, rowIndex: rowIndex));
          if (columnIndex < 6) {
            cell.cellStyle = cellBorderStyle;
          } else {
            cell.cellStyle = cellCheckStyle;
          }
        }
      }
      for (int rowIndex = 2; rowIndex < sheetTotal.maxRows; rowIndex++) {
        for (int k = 6; k < sheetTotal.maxColumns; k++) {
          var cell = sheetTotal.cell(Excel.CellIndex.indexByColumnRow(
              columnIndex: k, rowIndex: rowIndex));
          cell.value = Excel.FormulaCellValue(
              '=IF(AND(NOT(ISNA(MATCH(B${rowIndex + 1}, \'Buổi ${k - 5}\'!B:B, 0))), NOT(ISBLANK(INDEX(\'Buổi ${k - 5}\'!D:D, MATCH(B${rowIndex + 1}, \'Buổi ${k - 5}\'!B:B, 0)))), NOT(ISBLANK(INDEX(\'Buổi ${k - 5}\'!C:C, MATCH(B${rowIndex + 1}, \'Buổi ${k - 5}\'!B:B, 0))))), "x", "")');
          cell.cellStyle = cellCheckStyle;
        }
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
