import 'package:camera/camera.dart';
import 'package:get/get.dart';

class MyCameraController extends GetxController {
  static MyCameraController get instance => Get.find();
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  List<CameraDescription>? cameras;
  RxInt selectedCameraIndex = 0.obs;
  Rx<FlashMode> flashMode = FlashMode.off.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      selectedCameraIndex.value = 0;
      await setCamera(selectedCameraIndex.value);
    }
  }

  Future<void> setCamera(int index) async {
    if (cameraController.value != null) {
      await cameraController.value!.dispose();
    }
    cameraController.value = CameraController(
        cameras![index], ResolutionPreset.max,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    await cameraController.value!.initialize();
    await updateFlashMode(flashMode.value);
  }

  Future<void> updateFlashMode(FlashMode mode) async {
    try {
      await cameraController.value?.setFlashMode(mode);
      flashMode.value = mode;
    } catch (e) {
      print('Error setting flash mode: $e');
      return;
    }
  }

  void switchCamera() {
    selectedCameraIndex.value =
        (selectedCameraIndex.value + 1) % cameras!.length;
    setCamera(selectedCameraIndex.value);
  }

  void toggleFlash() {
    if (flashMode.value == FlashMode.off) {
      updateFlashMode(FlashMode.torch);
    } else {
      updateFlashMode(FlashMode.off);
    }
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }
}
