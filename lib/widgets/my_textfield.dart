import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.inputType,
    required this.hintText,
    this.icon,
    this.onChanged = _defaultOnChanged,
  });

  static void _defaultOnChanged(String value) {
    // Fungsi kosong
  }

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        controller: widget.controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
