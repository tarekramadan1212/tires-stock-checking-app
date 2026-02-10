import 'package:flutter/material.dart';
import '../utilities/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.child,this.onPressed,super.key});
  final Widget child;
  final void Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarySeed,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child:  child,
    );
  }
}
