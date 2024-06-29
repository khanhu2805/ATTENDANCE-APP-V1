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
    return ListTile(
      subtitle: Text(title),
      title: Text(content),
    );
    
  }
}
