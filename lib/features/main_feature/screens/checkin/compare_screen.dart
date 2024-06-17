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
    controller = Get.put(CheckinController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Obx(
          () => Container(
            child: controller.screen[controller.screenIndex.value],
            height: THelperFunctions.screenHeight() * 0.7,
            width: THelperFunctions.screenWidth(),
          ),
        ),
        bottomSheet: Obx(() => Text(controller.studentCode.value)),
      ),
    );
  }
}
