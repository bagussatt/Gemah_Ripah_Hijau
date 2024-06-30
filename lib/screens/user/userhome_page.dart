import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/login_page.dart'; // Import LoginPage
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserHomePage extends StatefulWidget {
  final String username;

  // Tambahkan konstruktor untuk menerima username
  UserHomePage({required this.username});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = widget.username;
    // Ambil data pengguna dari backend
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/user/$username'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        username = responseBody['username'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data pengguna')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Pengguna'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Selamat datang, $username!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Arahkan ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Selamat datang, $username!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
