import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grhijau/models/user.dart';

class UserRepository {
  final String baseUrl =
      'http://10.0.2.2:3000/users'; // Sesuaikan dengan base URL backend Anda

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody); // Pastikan User.fromJson sudah sesuai dengan struktur JSON
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
