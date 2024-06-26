import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/social_buttons.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:fe_attendance_app/common/widgets/login_signup/form_divider.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/login_form.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/login/widgets/login_header.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(THelperFunctions.screenWidth() / 20),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TLoginHeader(),
                TLoginForm(),
                TFormDivider(dividerText: AppTexts.orSignInWith),
                SizedBox(height: AppSizes.spaceBtwSections),
                AppSocialButtons(),
              ]),
        ),
      ),
    ));
  }
}
