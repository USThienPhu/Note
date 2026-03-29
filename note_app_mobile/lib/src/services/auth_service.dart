import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseURL = "http://10.0.2.2:3000/api/auth";
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await _storage.write(key: 'jwt_token', value: data['token']);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': data['error'] ?? 'Lỗi đăng nhập'};
      }
    } catch (err) {
      return {'success': false, 'message': 'Không thể kết nối Server: $err'};
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': 'email', 'password': password}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return {'success': true, 'message': 'Đăng ký thành công!'};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Lỗi đăng ký'};
      }
    }
    catch (e) {
      return {'success': false, 'message': 'Không thể kết nối Server'}; 
    }
  }

  Future<String?> getToken() async => await _storage.read(key: 'jwt_token');
}
