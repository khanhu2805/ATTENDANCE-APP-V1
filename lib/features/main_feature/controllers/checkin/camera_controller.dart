import 'package:camera/camera.dart';
import 'package:get/get.dart';

class MyCameraController extends GetxController {
  static MyCameraController get instance => Get.find();

  CameraController? cameraController;
  List<CameraDescription>? cameras;
  Rx<int> cameraIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      cameraController = CameraController(cameras![cameraIndex.value], ResolutionPreset.max);
      await cameraController!.initialize();
      update();
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}

