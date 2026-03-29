import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FootButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const FootButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.loginButtonColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
