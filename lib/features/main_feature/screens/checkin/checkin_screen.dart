import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/common/widgets/loaders/circular_loader.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/compare_screen.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:fe_attendance_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/checkin/checkin_controller.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  late CheckinController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(CheckinController());
    controller.getClassInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => !controller.loading.value
            ? controller.info != '' ? TAnimationLoaderWidget(
                text: controller.info,
                animation: AppImages.pencilAnimation,
                height: THelperFunctions.screenHeight() / 6,
                showAction: true,
                actionText: 'Bắt đầu',
                onActionPressed: () => {Get.to(() => const CompareScreen())},
              ): TAnimationLoaderWidget(text: 'Chưa tới ca điểm danh\nVui lòng quay lại sau', animation: AppImages.searchAnimation )
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.blue,),
                    Text('Lấy thông tin', style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                ),
            )),
      ),
    );
  }
}
