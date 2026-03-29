import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
class LogoText extends StatelessWidget {
  final double fontSize;
  final Color? color;

  const LogoText({super.key, this.fontSize = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      "NOTELY",
      style: GoogleFonts.titanOne(
        fontSize: 25,
        fontStyle: FontStyle.italic,
        color: AppColors.notelyText, // Hoặc màu chủ đạo bạn chọn
        letterSpacing: 2.0, // Giúp các chữ cái "dễ thở" hơn
        shadows: [
          Shadow(
            blurRadius: 10.0,
            color: Color(0x4CAF50),
            offset: const Offset(3, 3),
          ),
        ],
      ),
    );
  }
}
