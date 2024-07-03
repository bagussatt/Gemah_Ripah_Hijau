import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/complaint/createcomplaintpage.dart';
import 'package:grhijau/screens/user/complaint/readcomplaintspage.dart';
import 'package:grhijau/screens/user/login_page.dart';
import 'package:grhijau/screens/user/pickup/pickups.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserHomePage extends StatefulWidget {
  final String nama;

  UserHomePage({required this.nama});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String nama = '';
  String username = '';
  int userId = 1;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/user/${widget.nama}'));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        setState(() {
          username = responseBody['username'];
          userId = responseBody['id'];
        });
      } else {
        throw Exception('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
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
                'Welcome, $username!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Riwayat Keluhan Saya'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadComplaintsPage(userId: userId),
                  ),
                ); // Menutup drawer setelah navigasi selesai
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Ajukan Keluhan Sampah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateComplaintPage(userId: userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Ajukan Penjemputan Sampah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupPage(
                      userId: userId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, ${widget.nama}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('User ID: $userId', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
