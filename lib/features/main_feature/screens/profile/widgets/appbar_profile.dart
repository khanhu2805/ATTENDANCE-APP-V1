import 'package:fe_attendance_app/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TAppBar extends StatelessWidget {
  const TAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.fontSizeXl,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
