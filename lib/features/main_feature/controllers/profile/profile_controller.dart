import 'package:fe_attendance_app/features/authenticiation/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  RxString jobTitle = 'N/A'.obs;
  RxString displayName = 'N/A'.obs;
  RxString mail = 'N/A'.obs;

  @override
  void onInit() async{
    super.onInit();
    await _loadUserData(); 
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('Lỗi', 'Đăng xuất không thành công');
    }
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jobTitle.value = prefs.getString('jobTitle') ?? jobTitle.value;
      displayName.value = prefs.getString('displayName') ?? displayName.value;
      mail.value = prefs.getString('mail') ?? mail.value;
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải thông tin người dùng');
    }
  }
}
