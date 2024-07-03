import 'package:grhijau/models/user.dart';
import 'dart:convert';

import 'package:grhijau/sevices/authservice.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<User?> login(String username, String password) async {
    final response = await apiService.post('/users/login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
