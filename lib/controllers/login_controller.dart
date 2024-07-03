import 'package:grhijau/models/user.dart';
import 'package:grhijau/repositories/UserRepository.dart';

class LoginController {
  final UserRepository userRepository;

  LoginController({required this.userRepository});

  Future<User?> login(String username, String password) {
    return userRepository.login(username, password);
  }
}
