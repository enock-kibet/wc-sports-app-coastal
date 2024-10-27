import 'package:flutter/material.dart';


void showSnackBar(BuildContext context,
    {required String content, Color? bgColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: bgColor,
    ),
  );
}
