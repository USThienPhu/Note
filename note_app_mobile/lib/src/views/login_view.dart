import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app_mobile/src/widgets/text_button.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../utils/app_colors.dart';
import '../widgets/logo_notely.dart';
import 'home_view.dart';
import '../widgets/auth_header.dart';
import '../widgets/primary_button.dart';
import './register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginViewModel _viewModel = LoginViewModel();
  final Color backgroundColor = AppColors.backgroundColor;

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

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              LogoText(),
              const SizedBox(height: 16),
              AuthHeader(
                title: "Welcome Back",
                subtitle: "Login to continue your note-taking journey.",
              ),
              const SizedBox(height: 50),
              // Ô nhập Email
              CustomTextField(
                label: "Email address",
                hint: "example@gmail.com",
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Password",
                hint: "@Notely2026",
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 40),
              Selector<LoginViewModel, bool>(
                selector: (context, viewModel) => viewModel.isLoading,
                builder: (context, isLoading, child) {
                  return PrimaryButton(
                    label: "LOGIN",
                    onPressed: _handleLogin,
                    isLoading: isLoading,
                  );
                },
              ),
              const SizedBox(height: 10),
              FootButton(
                label: "Don't have an account? Sign Up",
                onPressed: _navigateToRegister,
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
