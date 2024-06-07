import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/authenticiation/screens/home/home_screen.dart';
import '../../features/authenticiation/screens/login/login.dart';
import '../../features/authenticiation/screens/onboarding/onboarding.dart';
import '../exceptions/firebase_auth_exceptions.dart';
import '../exceptions/format_exceptions.dart';
import '../exceptions/platform_exceptions.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async{
    final user = _auth.currentUser;

    if (user != null){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => HomeScreen());
      });

    } else {
      deviceStorage.writeIfNull("IsFirstTime", true);

      deviceStorage.read("IsFirstTime") != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnBoardingScreeen());
    }
  }
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }on FormatException catch (e) {
      throw const TFormatException();
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch(e){
      throw 'Somthing went wrong. Please try again';
    }
  }
}
