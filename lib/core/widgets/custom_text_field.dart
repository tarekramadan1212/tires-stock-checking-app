import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    super.key,
  });

  final String hintText;
  final Icon? prefixIcon;
  final int? maxLines;
  final int? maxLength;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines??1,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
