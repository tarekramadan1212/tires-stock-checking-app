import 'package:flutter/material.dart';

void showResetSentDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Force them to press OK
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: const Icon(Icons.mark_email_read_outlined, size: 50, color: Colors.blue),
      title: const Text("Check Your Email"),
      content: const Text(
        "If an account exists for this email, you will receive a password reset link shortly. Please check your spam folder if you don't see it.",
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Go back to Login Screen
          },
          child: const Text("OK, GOT IT"),
        ),
      ],
    ),
  );
}