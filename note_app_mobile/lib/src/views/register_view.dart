import 'package:flutter/material.dart';
import 'package:note_app_mobile/src/widgets/auth_header.dart';
import 'package:note_app_mobile/src/widgets/custom_text_field.dart';
import 'package:note_app_mobile/src/widgets/logo_notely.dart';
import '../utils/app_colors.dart';
import '../widgets/text_button.dart';
import '../widgets/primary_button.dart';
import '../viewmodels/register_viewmodel.dart';
import '../views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final Color backgroundColor = AppColors.backgroundColor;
  final RegisterViewModel _viewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  void _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController1.text.trim();
    final password2 = _passwordController2.text.trim();
    if (password != password2) {
      _showSnackBar("Mật khẩu xác nhận không khớp", Colors.red);
      return;
    }

    final result = await _viewModel.register(
      email,
      password,
    );

    if (result['success']) {
      _showSnackBar(result['message'], Colors.green);

      // Đăng ký xong thì quay lại trang Login sau 1 giây để người dùng kịp đọc thông báo
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pop(context);
      });
    } else {
      _showSnackBar(result['message'], Colors.red);
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
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
                title: "Create a free account",
                subtitle:
                    "Join Notely for free. Create and share unlimited notes with your friends.",
              ),

              const SizedBox(height: 50),
              CustomTextField(
                label: "Email",
                hint: "Nhập email của bạn",
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Mật khẩu",
                hint: "Nhập mật khẩu",
                controller: _passwordController1,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Mật khẩu",
                hint: "Nhập lại mật khẩu",
                controller: _passwordController2,
                isPassword: true,
              ),
              const SizedBox(height: 40),

              PrimaryButton(
                label: "REGISTER",
                onPressed: _handleRegister,
                isLoading: _viewModel.isLoading,
              ),
              const SizedBox(height: 10),
              FootButton(
                label: "Already have an account?",
                onPressed: _navigateToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
