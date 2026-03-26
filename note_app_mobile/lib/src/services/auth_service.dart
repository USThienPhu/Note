import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.0.2.2:3000/api/auth";

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        print("Login successfullu");
        print("Data: ${response.body}"); //Token
      } else {
        print("Login error: ${response.statusCode}");
      }
    } catch (err) {
      print("Can not connect to server");
    }
  }
}
