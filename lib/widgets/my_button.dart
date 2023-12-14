import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    this.buttonColor = Colors.purple,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.width,
      height: 50,
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}