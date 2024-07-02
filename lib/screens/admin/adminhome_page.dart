import 'package:flutter/material.dart';
import 'package:grhijau/screens/admin/complaints/complaintadmin.dart';
import 'package:grhijau/screens/admin/feedback/feedbacklist.dart';
import 'package:grhijau/screens/admin/pickups/pickupsread.dart';
import 'package:grhijau/screens/admin/register_page.dart';
import 'package:grhijau/screens/user/login_page.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Admin'),
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
                'Selamat datang, Admin!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Halaman Daftar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Riwayat Keluhan Pengguna'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadComplaintsAdmin(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Feedback Pengguna'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackListPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Riwayat Penjemputan Sampah'), // Tambahkan ini
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadPickupsAdmin(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Hapus data login di sini jika ada, lalu arahkan ke halaman login
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
        child: Text('Selamat datang, Admin!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
