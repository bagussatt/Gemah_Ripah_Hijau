import 'package:flutter/material.dart';
import 'package:grhijau/controllers/login_controller.dart';
import 'package:grhijau/models/user.dart';
import 'package:grhijau/repositories/UserRepository.dart';
import 'package:grhijau/screens/admin/adminhome_page.dart';
import 'package:grhijau/screens/user/userhome_page.dart';
import 'package:grhijau/sevices/authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController(
    userRepository: UserRepository(
      apiService: ApiService(baseUrl: 'http://10.0.2.2:3000'),
    ),
  );

  String _message = '';
  String _enteredUsername = '';
  String _enteredPassword = '';

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    setState(() {
      _enteredUsername = username;
      _enteredPassword = password;
    });

    User? user = await _loginController.login(username, password);

    if (user != null) {
      setState(() {
        _message = 'Login berhasil sebagai ${user.username}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil sebagai ${user.username}')),
      );

      // Navigasi berdasarkan peran pengguna
      if (user.role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UserHomePage(
                    username: user.username,
                  )),
        );
      }
    } else {
      setState(() {
        _message = 'Login gagal';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text('Username: $_enteredUsername'),
            Text('Password: $_enteredPassword'),
            SizedBox(height: 20),
            Text(_message, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
