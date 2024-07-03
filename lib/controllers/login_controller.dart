import 'package:grhijau/models/user.dart';
import 'package:grhijau/sevices/authservice.dart'; // Pastikan penulisan nama file dan import benar

class UserController {
  final AuthService _authService = AuthService();

  Future<User> login(String username, String password) async {
    try {
      // Panggil fungsi login dari AuthService
      User user = await _authService.login(username, password);
      return user; // Kembalikan objek User jika login berhasil
    } catch (e) {
      throw e; // lempar kembali error jika terjadi kesalahan
    }
  }
}
