import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> register(String email, String password, String name) async {
    _setIsLoading(true);

    // Gọi hàm register từ AuthService (Phú cần thêm hàm này vào AuthService nhé)
    final result = await _authService.register(email, password, name);
    
    _setIsLoading(false);
    return result;
  }

  // Hàm cập nhật trạng thái loading và báo cho UI vẽ lại
  void _setIsLoading(bool state) {
    _isLoading = state;
    notifyListeners(); // Đây là "tiếng chuông" báo cho UI biết dữ liệu đã đổi
  }
}
