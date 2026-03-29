import 'package:flutter/material.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../utils/app_colors.dart';
import '../widgets/logo_notely.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_view.dart';
import '../widgets/auth_header.dart';
import '../widgets/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _viewModel = LoginViewModel();
  // Định nghĩa bảng màu theo thiết kế Notely
  final Color primaryColor = const Color.fromARGB(255, 170, 36, 47);
  final Color backgroundColor = AppColors.backgroundColor;

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _handleLogin() async {
    final result = await _viewModel.login(
      _emailController.text,
      _passwordController.text,
    );

    if (!mounted) return;

    if (result['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 24),

              LogoText(),
              const SizedBox(height: 24),
              AuthHeader(
                title: "Welcome Back",
                subtitle: "Login to continue your note-taking journey.",
              ),
              const SizedBox(height: 50),
              // Ô nhập Email
              CustomTextField(
                label: "Email",
                hint: "Nhập email của bạn",
                controller: _emailController,
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Mật khẩu",
                hint: "Nhập mật khẩu",
                controller: _passwordController,
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 40),
              // Nút Đăng nhập hoặc Loading
              PrimaryButton(
                label: "LOGIN",
                onPressed: _handleLogin,
                isLoading: _viewModel.isLoading,
              ),

              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Create account",
                  style: TextStyle(
                    color: AppColors.loginButtonColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
