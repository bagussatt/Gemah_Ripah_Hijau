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

  void _login() async {
    try {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isNotEmpty && password.isNotEmpty) {
        final User user = await _userController.login(username,
            password); // Pastikan model User telah diimpor dengan benar

        if (user.username == 'admin') {
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
          SnackBar(content: Text('Username and password are required')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _nama,
              decoration:
                  InputDecoration(labelText: 'Konfirmasi Ulang Username'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
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
