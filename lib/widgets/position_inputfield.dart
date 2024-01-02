import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kp_project/constant/colors.dart';

class PositionInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int? maxLine;
  final TextInputType inputType;

  const PositionInputField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.maxLine = 1,
      this.inputType = TextInputType.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    if (inputType == TextInputType.number) {
      inputFormatters = [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.digitsOnly,
      ];
    } else if (inputType == TextInputType.text) {
      inputFormatters = [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]*$')),
        UppercaseInputFormatter(),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Input field
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          textAlign: TextAlign.start,
          maxLines: maxLine,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              gapPadding: 5.0,
              borderSide: const BorderSide(
                color: darkBlue,
              ),
            ),
            alignLabelWithHint: true,
          ),
        ),

        // Spacer
        const SizedBox(
          height: 5,
        ),

        // Label text
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

//Untuk auto huruf besar saat diinput
class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
