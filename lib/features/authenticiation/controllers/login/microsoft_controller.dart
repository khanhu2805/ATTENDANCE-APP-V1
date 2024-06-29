import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/repository/authentication_repository.dart';

class MicrosoftControlller extends GetxController {
  Rxn<User> user = Rxn<User>();

  Future<void> signInWithMicrosoft() async {
    final provider = OAuthProvider('microsoft.com');
    provider.setCustomParameters({
      'prompt': 'consent',
      'tenant': '98ada680-e3f4-48cb-8fbb-c8b10cb97aed',
    });
    final scopes = [
      'mail.read',
      'calendars.read',
    ];

    try {
      TFullScreenLoader.openLoadingDialog(
            "Đang đăng nhập ...", AppImages.securityAnimation);
      final userCredential = await FirebaseAuth.instance.signInWithProvider(
        provider..addScope(scopes.join(' ')),
      );
      print('Token: ${userCredential.credential!.accessToken}');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      user.value = userCredential.user;
      if (user.value != null) {
        final userEmail = user.value!.email;
        if (userEmail != null) {
          await prefs.setBool('rememberMe', true);
        }

        print('Name: ${FirebaseAuth.instance.currentUser?.displayName}');
        print('profile: ${userCredential.additionalUserInfo?.profile}');

        await prefs.setString('jobTitle', userCredential.additionalUserInfo?.profile?['jobTitle'] ?? '');
        await prefs.setString('displayName', userCredential.additionalUserInfo?.profile?['displayName'] ?? '');
        await prefs.setString('mail', userCredential.additionalUserInfo?.profile?['mail'] ?? '');

        AuthenticationRepository.instance.screenRedirect();
      } else {
        print('Đăng nhập lỗi: tài khoản không tồn tại');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
      } else {
        print('Lỗi đăng nhập với tài khoản Microsoft: ${e.message}');
      }
    }
  }
}
