import 'package:fe_attendance_app/features/authenticiation/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => const LoginScreen());
  }
}