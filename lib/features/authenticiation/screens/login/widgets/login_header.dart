import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class TLoginHeader extends StatelessWidget {
  const TLoginHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
            height:150,
            image: AssetImage(AppImages.lightAppLogo)
        ),
        Text(AppTexts.loginTitle),
        SizedBox(height: AppSizes.sm),
        Text(AppTexts.loginSubTitle),
      ],
    );
  }
}
