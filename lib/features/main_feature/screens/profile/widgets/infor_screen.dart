import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/constants/sizes.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TInforScreen extends StatelessWidget {
  const TInforScreen({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(  
          children: [
            Text( 
              title,
              style: TextStyle(
                fontSize: AppSizes.fontSizeLg,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(), 
            SizedBox( 
              width: MediaQuery.of(context).size.width -200, 
              child: Text(
                content,
                style: const TextStyle(fontSize: AppSizes.fontSizeLg),
                softWrap: true,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class TInforHeaderScreen extends StatelessWidget {
  const TInforHeaderScreen({
    super.key,
    required this.displayName,
    required this.jobTitle,
  });

  final String displayName;
  final String jobTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: THelperFunctions.screenHeight() / 8,
      width: THelperFunctions.screenWidth(),
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.pastelBlue, AppColors.yellow],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 30),
        const Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(AppImages.erroImageProfile),
          ),
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(displayName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        const SizedBox(height: 5),
        Center(child: Text(jobTitle, style: const TextStyle(fontSize: 18))),
        const SizedBox(height: 20),
      ]),
    );
  }
}
