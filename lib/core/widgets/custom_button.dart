import 'package:flutter/material.dart';
import '../utilities/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.child,this.onPressed,super.key, this.color});
  final Widget child;
  final void Function()? onPressed;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: color??AppColors.primarySeed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:  child,
      ),
    );
  }
}
