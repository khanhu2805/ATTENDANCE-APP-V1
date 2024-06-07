import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../screens/login/login.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }

  User? get user => _user.value;

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => const LoginScreen());
  }

}
