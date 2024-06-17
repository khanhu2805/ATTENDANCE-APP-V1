import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  late CheckinController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      scanWindow: Rect.fromCenter(center: Offset(THelperFunctions.screenWidth()/2, THelperFunctions.screenHeight()*0.7/2), width: THelperFunctions.screenWidth() * 0.8, height: THelperFunctions.screenHeight()/4),
      cutOutSize: 0.0,
      cutOutHeight: THelperFunctions.screenHeight()/4,
      cutOutWidth: THelperFunctions.screenWidth() * 0.8,
      cutOutBottomOffset: THelperFunctions.screenHeight()/30,
      fit: BoxFit.cover,
      onDetect: (p0) async {
        String barcode = p0.barcodes.first.rawValue.toString();
        controller.checkStudentCode(barcode);
      },
    );
  }
}
