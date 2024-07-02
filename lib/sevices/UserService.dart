import '../models/User.dart';
import '../repositories/UserRepository.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<User> loginUser(String username, String password) async {
    return await _userRepository.loginUser(username, password);
  }
}