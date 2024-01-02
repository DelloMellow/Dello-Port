import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';

class MyIconButton extends StatelessWidget {
  final Color buttonColor;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.text,
    this.buttonColor = steelBlue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      elevation: 3,
      color: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Button Icon
          Icon(icon, size: 40, color: Colors.white),
      
          const SizedBox(
            width: 10,
          ),
      
          //Button Text
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
