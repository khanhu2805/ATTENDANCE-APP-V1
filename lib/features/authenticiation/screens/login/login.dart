import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/social_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fe_attendance_app/common/widgets/login_signup/form_divider.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/login_form.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/login_header.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../authenticiation/screens/login/widgets/HeaderLogin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: Header_Login.paddingwithAppBarHeight,
              child: Column(
                  children: [
                    TLoginHeader(),
                    TLoginForm(),
                    TFormDivider(dividerText: AppTexts.orSignInWith),
                    SizedBox(height: AppSizes.spaceBtwSections),
                    AppSocialButtons(),
                  ]
              ),
            ),
          ),
        )
    );
  }
}
