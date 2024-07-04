import 'package:flutter/material.dart';
import 'package:grhijau/controllers/login_controller.dart'; // Sesuaikan dengan path yang benar
import 'package:grhijau/screens/user/userhome_page.dart'; // Sesuaikan dengan path yang benar
import 'package:grhijau/screens/admin/adminhome_page.dart'; // Sesuaikan dengan path yang benar
import 'package:grhijau/models/user.dart'; // Sesuaikan dengan path yang benar

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _userController =
      UserController(); // Sesuaikan dengan controller yang benar

  bool _isObscured =
      true; // Untuk mengatur apakah password dienkripsi atau tidak

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _login() async {
    try {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isNotEmpty && password.isNotEmpty) {
        final User user = await _userController.login(username,
            password); // Pastikan model User telah diimpor dengan benar

        if (user.role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdminHomePage(), // Navigasi ke AdminHomePage
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserHomePage(
                  nama: _nama.text), // Mengirim username dan userId
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username dan password kosong')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal Login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Menghilangkan margin bawah saat keyboard muncul
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Container(
        color: Colors.lightGreen, // Warna latar belakang hijau muda
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image(
                image: NetworkImage(
                    'https://kkprirsmdjamil.com/wp-content/uploads/2022/08/koperasi-flag-web-1024x614.webp'),
                height: 200, // Ukuran gambar yang melingkar
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 26.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _nama,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Ulang Username',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
