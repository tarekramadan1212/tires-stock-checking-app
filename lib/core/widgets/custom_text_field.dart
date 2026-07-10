import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.hintText,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.fillColor,
    this.enabled,
    this.readOnly,
    super.key,
  });

  final String hintText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? enabled;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      maxLines: maxLines??1,
      maxLength: maxLength,
      enabled: enabled??true,
      readOnly: readOnly??false,
      obscureText: obscureText??false,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: const TextStyle(color: Colors.grey),
        border: border??OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: focusedBorder?? OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: enabledBorder??OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: fillColor??Colors.grey[270],
      ),
    );
  }
}
