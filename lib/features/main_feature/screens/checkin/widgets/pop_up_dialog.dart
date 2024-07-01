import 'dart:async';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpDialog extends StatefulWidget {
  const PopUpDialog(
      {super.key,
      required this.seconds,
      required this.widget,
      required this.result});
  final int seconds;
  final Widget widget;
  final bool result;
  @override
  State<PopUpDialog> createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {
  late Timer _timer;
  late int seconds;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    seconds = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _timer.cancel();
          Get.back();
          widget.result
              ? null
              : CheckinController.instance.screenIndex.value = 0;
          // Navigator.of(context).pop;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      insetPadding:
          EdgeInsets.symmetric(horizontal: THelperFunctions.screenWidth() / 20),
      content: widget.widget,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ElevatedButton(
          onPressed: () {
            _timer.cancel();
            Get.back();
            widget.result
                ? null
                : CheckinController.instance.screenIndex.value = 0;
            // Navigator.of(context).pop;
          },
          child: Text('${widget.result ? 'Đóng' : 'Thử lại'} ($seconds)'),
        ),
      ],
    );
  }
}
