import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
    return ListTile(
      subtitle: Text(title),
      title: Text(content),
    );
    
  }
}
