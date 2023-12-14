import 'package:flutter/material.dart';

class MyConfirmDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String cancelText;
  final String confirmText;
  final Function onConfirm;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;

  const MyConfirmDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    this.cancelText = "Cancel",
    required this.confirmText,
    required this.onConfirm,
    this.icon = Icons.error,
    this.iconColor = Colors.yellow,
    this.buttonColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        icon: Icon(
          icon,
          size: 100,
          color: iconColor,
        ),
        title: Text(titleText),
        content: Text(
          contentText,
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  cancelText,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              //confirm button
              MaterialButton(
                color: buttonColor,
                onPressed: () {
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: Text(
                  confirmText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
