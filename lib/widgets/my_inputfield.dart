import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final TextInputType inputType;
  final int? maxLine;
  final bool isEnable;
  final bool isOptional;

  const MyInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    required this.inputType,
    this.maxLine = 1,
    this.isEnable = true,
    this.isOptional = false,
  });

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool isError = true;

  @override
  Widget build(BuildContext context) {
    //untuk format inputan angka
    List<TextInputFormatter> inputFormatters = [];

    if (widget.inputType == TextInputType.number) {
      inputFormatters = [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.digitsOnly,
      ];
    }

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
            inputFormatters: inputFormatters,
            textAlign: TextAlign.start,
            maxLines: widget.maxLine,
            enabled: widget.isEnable,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
