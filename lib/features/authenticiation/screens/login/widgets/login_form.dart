import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => AppValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: AppTexts.username),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                validator: (value) => AppValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: AppTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.rememberMe.value =
                            !controller.rememberMe.value;
                      },
                      child: Text(
                        AppTexts.rememberMe,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: THelperFunctions.screenWidth() * 0.035),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                child: Text(
                  AppTexts.forgetPassword,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.035),
                )),
            const SizedBox(height: AppSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller
                    .emailAndPasswordSignIn(controller.rememberMe.value),
                child: const Text(
                  AppTexts.signIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
