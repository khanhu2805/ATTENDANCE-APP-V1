import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/compare_screen.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkin/checkin_controller.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TAnimationLoaderWidget(
          text: 'Ca điểm danh\nHọc phần: 2222222\nNgày: 16/06/2024 - Buổi 1',
          animation: AppImages.pencilAnimation,
          height: THelperFunctions.screenHeight() / 6,
          showAction: true,
          actionText: 'Bắt đầu',
          onActionPressed: () => {Get.to(() => CompareScreen())},
        ),
      ),
    );
  }
}
