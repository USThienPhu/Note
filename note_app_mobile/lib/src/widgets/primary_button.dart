import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key, 
    required this.label, 
    required this.onPressed, 
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.loginButtonColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 62),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2.0),
            ),
          );
  }
}