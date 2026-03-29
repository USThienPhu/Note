import 'package:flutter/material.dart';
import 'package:note_app_mobile/src/views/home_view.dart';
import 'src/views/login_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData (
        useMaterial3: true, // Xu hướng 2026 là luôn dùng Material 3
        textTheme: GoogleFonts.nunitoTextTheme(), // Ngắn gọn và sạch sẽ
      ),
      title: 'Note application',
      debugShowCheckedModeBanner: false,
      home: const HomeView()
    );

  }
}
