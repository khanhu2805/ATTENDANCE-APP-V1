import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import 'widgets/my_mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  late CheckinController controller;
  late MobileScannerController mobileScannerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
    mobileScannerController = MobileScannerController(facing: controller.facing? CameraFacing.front: CameraFacing.back, torchEnabled: controller.flashing.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                mobileScannerController.switchCamera();
                controller.facing = !controller.facing;
              },
              icon: const Icon(
                Icons.cameraswitch_rounded,
              )),
          IconButton(
              icon: Icon(!controller.flashing.value
                  ? Icons.flashlight_off_rounded
                  : Icons.flashlight_on_rounded),
              onPressed: () => {mobileScannerController.toggleTorch(),
              controller.flashing.value = !controller.flashing.value}),
        ],
      ),
      body: Stack(
        children: [
          MyMobileScanner(
            onDetect: (p0) async {
              String barcode = p0.barcodes.first.rawValue.toString();
              controller.checkStudentCode(barcode);
            },
            controller: mobileScannerController,
            fit: BoxFit.cover,
            // errorBuilder:
            //     widget.errorBuilder ?? (_, error, ___) => const ErrorBuilder(),
            // placeholderBuilder: widget.placeholderBuilder,
            scanWindow: Rect.fromCenter(
                center: Offset(THelperFunctions.screenWidth() / 2,
                    THelperFunctions.screenHeight() * 0.7 / 2),
                width: THelperFunctions.screenWidth() * 0.9,
                height: THelperFunctions.screenHeight() / 3),
            // key: widget.key,
            // overlayBuilder: widget.overlayBuilder,
            // scanWindowUpdateThreshold: widget.scanWindowUpdateThreshold,
          ),
          Container(
            decoration: ShapeDecoration(
              shape: OverlayShape(
                borderRadius: 24,
                borderColor: Colors.white,
                borderLength: 42,
                borderWidth: 12,
                cutOutSize: 0.0,
                cutOutHeight: THelperFunctions.screenHeight() / 4,
                cutOutWidth: THelperFunctions.screenWidth() * 0.8,
                cutOutBottomOffset: THelperFunctions.screenHeight() / 30,
                overlayColor: const Color.fromRGBO(0, 0, 0, 82),
              ),
            ),
          ),
          // Container(
          //   // width: THelperFunctions.screenWidth(),
          //   // alignment: Alignment.topRight,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [

          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
