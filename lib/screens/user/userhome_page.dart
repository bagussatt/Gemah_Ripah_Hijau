import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
        throw Exception(
            'Gagal mengambil data pengguna: ${response.statusCode}');
      }
    } catch (e) {
      print('Gagal mengambil data pengguna: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data pengguna')),
      );
    }
  }

  Future<void> _confirmLogout(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Keluar'),
              onPressed: () {
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Color.fromARGB(255, 64, 107, 15),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text(
                'Selamat Datang, $username!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _confirmLogout(context);
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Selamat Datang, ${widget.nama}',
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('User ID: $userId', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: [
                'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1640003094/ckemgunl9n6lvzlkbrnz.jpg',
                'https://sgp1.digitaloceanspaces.com/p.storage/wp-content/uploads/2023/02/20225425/Ari-dan-Samijan-dua-dari-sepuluh-tenaga-kebersihan-pasar-berkeliling-dari-kios-ke-kios2.jpg',
                'https://d1yc6vwxvprgjf.cloudfront.net/id/gallery_images/x_medium/1434489083/530578?1434489083'
              ].map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 6, 69, 29).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'Hari ini Tim Pengangkut Sampah beroperasi dari jam 9 sampai jam 14.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.report_problem, size: 50),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateComplaintPage(userId: userId),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Ajukan Keluhan'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.local_shipping, size: 50),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PickupPage(userId: userId),
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Penjemputan'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightGreen,
    );
  }
}
