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
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception('Lỗi lấy dữ liệu: ${response.statusCode}');
    }
  }

  Future<Note?> createNote(String title, String content) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'title': title, 'content': content}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return Note.fromJson(data);
    }

    return null;
  }

  Future<bool> updateNote(String id, String title, String content) async {
    try {
      final token = await _authService.getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': content, 'title': title}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error in _saveNote: $e");
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    try {
      final token = await _authService.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode.toString());
      print(jsonDecode(response.body));
      return response.statusCode == 200;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
