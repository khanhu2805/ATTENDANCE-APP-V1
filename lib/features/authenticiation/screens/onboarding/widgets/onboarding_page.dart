import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: AssetImage(image),
              width: DeviceUtils.getScreenWidth() / 2,
              height: DeviceUtils.getScreenHeight() / 3,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.06),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 10.0,
            ),
            Text(subTitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: THelperFunctions.screenWidth() * 0.035),
                textAlign: TextAlign.center)
          ],
        ));
  }
}
