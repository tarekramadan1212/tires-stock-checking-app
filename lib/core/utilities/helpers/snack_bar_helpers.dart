import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
  ));
}