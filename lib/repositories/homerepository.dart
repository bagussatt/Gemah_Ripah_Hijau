import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grhijau/models/user.dart';

class HomeRepository {
  final String baseUrl;

  HomeRepository({required this.baseUrl});

  Future<User?> getUserByUsername(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$username'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody);
    } else {
      return null;
    }
  }
}
