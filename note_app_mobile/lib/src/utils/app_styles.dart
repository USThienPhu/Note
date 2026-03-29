import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.textBlack,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textBlack,
  );
  
  // Định nghĩa luôn khoảng cách để dùng thay SizedBox(height: 20)
  static const double paddingLarge = 20.0;
  static const double borderRadius = 15.0;
}