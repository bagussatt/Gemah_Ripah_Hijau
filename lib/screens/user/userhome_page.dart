import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/pickup/pickups.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:grhijau/screens/user/complaint/createcomplaintpage.dart';
import 'package:grhijau/screens/user/complaint/readcomplaintspage.dart';
import 'package:grhijau/screens/user/login_page.dart';

class UserHomePage extends StatefulWidget {
  final String username;

  UserHomePage({required this.username});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late String username;
  late int userId; // Initialize userId

  @override
  void initState() {
    super.initState();
    username = widget.username;
    userId = 0; // Initialize userId here
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/user/$username'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        username = responseBody['username'];
        userId = responseBody['id']; // Assign userId after fetching user data
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
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
                );
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
                    builder: (context) => PickupPage(userId: userId),
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
            Text('Welcome, $username!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            if (userId != 0)
              Text('User ID: $userId', style: TextStyle(fontSize: 18)),
            if (userId == 0)
              CircularProgressIndicator(), // Show loading indicator only when userId is 0
          ],
        ),
      ),
    );
  }
}
