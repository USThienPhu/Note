import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';
import '../models/note_model.dart';

class NoteService {
  final String baseUrl = "http://10.0.2.2:3000/api/notes";
  final AuthService _authService = AuthService();

  Future<List<Note>> fetchMyNote() async {
    final token = await _authService.getToken();

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception('Lỗi lấy dữ liệu: ${response.statusCode}');
    }
  }
}
