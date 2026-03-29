import 'package:flutter/material.dart';
import 'package:note_app_mobile/src/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final Color? primaryColor; 

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    // final themeColor = primaryColor ?? Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, 
                                fontSize: 15),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              
              hintStyle: TextStyle(
                color: AppColors.greyText, 
                fontWeight: FontWeight.bold),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
            ),
          ),
        ),
      ],
    );
  }
}