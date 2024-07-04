import 'package:flutter/material.dart';
import 'package:grhijau/screens/admin/pickups/pickupdetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReadPickupsAdmin extends StatefulWidget {
  @override
  _ReadPickupsAdminState createState() => _ReadPickupsAdminState();
}

class _ReadPickupsAdminState extends State<ReadPickupsAdmin> {
  List<dynamic> pickups = [];

  @override
  void initState() {
    super.initState();
    _fetchPickups();
  }

  Future<void> _fetchPickups() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/pickups/read'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        pickups = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data penjemputan sampah')),
      );
    }
  }

  void _navigateToPickupDetail(int pickupId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPickups(pickupId: pickupId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Penjemputan Sampah'),
      ),
      body: pickups.isEmpty
          ? Center(child: Text('Tidak ada data penjemputan sampah'))
          : ListView.builder(
              itemCount: pickups.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    title: Text('Penjemputan ID: ${pickups[index]['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${pickups[index]['status']}'),
                        Text('Catatan: ${pickups[index]['catatan']}'),
                        Text('Waktu: ${pickups[index]['waktu']}'),
                        Text('Lokasi: ${pickups[index]['lokasi']}'),
                        Divider(height: 15),
                      ],
                    ),
                    onTap: () {
                      _navigateToPickupDetail(pickups[index]['id']);
                    },
                  ),
                );
              },
            ),
    );
  }
}
