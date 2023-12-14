import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType inputType;
  final int? maxLine;
  final bool isEnable;

  const MyInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = "",
    required this.inputType,
    this.maxLine = 1,
    this.isEnable = true,
  });

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //label text
          Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),

          //spacer
          const SizedBox(
            height: 5,
          ),

          //input field
          TextField(
            controller: widget.controller,
            keyboardType: widget.inputType,
            textAlign: TextAlign.start,
            maxLines: widget.maxLine,
            enabled: widget.isEnable,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 5.0,
                borderSide: const BorderSide(
                  color: darkBlue,
                ),
              ),
              alignLabelWithHint: true,
            ),
          )
        ],
      ),
    );
  }
}
