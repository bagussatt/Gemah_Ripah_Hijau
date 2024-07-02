import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/User.dart';

class UserRepository {
  static const String baseUrl = 'http://10.0.2.2:3000/users';

  Future<User> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody);
    } else {
      throw Exception('Failed to login');
    }
  }
}
