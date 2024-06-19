import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late CheckinController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(children: [
            Container(
              height: THelperFunctions.screenHeight() * 0.7,
              width: THelperFunctions.screenWidth(),
              child: controller.screen[controller.screenIndex.value],
            ),
            Container(
              margin:
                  EdgeInsets.only(top: THelperFunctions.screenHeight() * 0.05),
              alignment: Alignment.center,
              child: controller.studentCode.value != ''
                  ? controller.studentCode.value != '0'
                      ? Text(
                          'Mã sinh viên: ${controller.studentCode.value}\nVui lòng đưa gương mặt vào khung quy định')
                      : Text('Sinh viên không có trong danh sách lớp')
                  : Text('Vui lòng quét mã vạch trên thẻ sinh viên'),
            )
          ]),
        ),
      ),
    );
  }
}
