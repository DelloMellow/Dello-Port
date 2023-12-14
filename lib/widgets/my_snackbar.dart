import 'package:flutter/material.dart';

class MySnackBar {
  static void show(
    BuildContext context, {
    String message = "Default message",
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = const Color.fromARGB(255, 190, 53, 44),
    Color textColor = Colors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
