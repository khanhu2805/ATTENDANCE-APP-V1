import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/repository/authentication_repository.dart';

class LoginController extends GetxController {
  var rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => NetworkManager());
  }

  void _saveRememberMe(bool _rememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', _rememberMe);
  }

  Future<void> emailAndPasswordSignIn(bool _rememberMe) async {
    _saveRememberMe(_rememberMe);
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang đăng nhập ...", AppImages.securityAnimation);
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (FirebaseAuth.instance.currentUser == null) {
        final userCredentials = await AuthenticationRepository.instance
            .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
        if (userCredentials.user != null) {
          TFullScreenLoader.stopLoading();
          AuthenticationRepository.instance.screenRedirect();
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (e is FirebaseAuthException) {
        AppLoaders.errorSnackBar(
            title: "Lỗi Đăng Nhập",
            message: e.message ?? "Thông tin đăng nhập không chính xác");
      } else {
        AppLoaders.errorSnackBar(title: "On Snap...", message: e.toString());
      }
    }
  }
}
