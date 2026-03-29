import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> login(String email, String passwod) async {
    _setIsLoading(true);

    final result = await _authService.login(email, passwod);
    _setIsLoading(false);

    return result;
  }

  void _setIsLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
