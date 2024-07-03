import 'package:grhijau/models/user.dart';
import 'package:grhijau/repositories/UserRepository.dart';

class AuthService {
  final UserRepository _userRepository = UserRepository();

  Future<User> login(String username, String password) async {
    try {
      // Panggil fungsi login dari UserRepository
      User user = await _userRepository.login(username, password);
      return user; // Kembalikan objek User jika login berhasil
    } catch (e) {
      throw e; // Lemparkan kembali error jika terjadi kesalahan
    }
  }
}
