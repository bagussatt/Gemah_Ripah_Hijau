import 'package:flutter/material.dart';
import 'package:grhijau/controllers/read_pickup_controller.dart';
import 'package:grhijau/models/readpickup.dart';
import 'package:grhijau/screens/user/pickup/createpickup.dart';
import 'package:grhijau/screens/user/pickup/detailpickups.dart';

class PickupPage extends StatefulWidget {
  final int userId;

  PickupPage({required this.userId});

  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  final ReadPickupsController _controller = ReadPickupsController();

  Future<void> _fetchPickups() async {
    await _controller.fetchPickups();
  }

  void navigateToCreatePickupPage() {
    // Perubahan nama fungsi
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePickupPage(
            userId: widget.userId), // Navigasi ke CreatePickupPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Pickups'),
        backgroundColor: Color.fromARGB(
            255, 29, 154, 77), // Ubah warna AppBar menjadi hijau muda
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: navigateToCreatePickupPage, // Perubahan onPressed
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchPickups,
        child: FutureBuilder<List<ReadPickup>>(
          future: _controller.fetchPickups(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Failed to fetch pickups: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No pickups available'));
            } else {
              List<ReadPickup> pickups = snapshot.data!;
              return ListView.builder(
                itemCount: pickups.length,
                itemBuilder: (context, index) {
                  final pickup = pickups[index];
                  return ListTile(
                    title: Text('Pickup ID: ${pickup.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Waktu: ${pickup.formattedDateTime()}'),
                        Text('Lokasi: ${pickup.lokasi}'),
                        Text(
                            'Catatan: ${pickup.catatan ?? 'Tidak ada catatan'}'),
                        Divider(height: 15),
                      ],
                    ),
                    trailing: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(pickup.status).withOpacity(0.1),
                        border: Border.all(
                          color: _getStatusColor(pickup.status),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        pickup.status,
                        style: TextStyle(
                          color: _getStatusColor(pickup.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPickupsPage(
                            userId: widget.userId,
                            pickup: pickup.toJson(),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      backgroundColor:
          Colors.lightGreen, // Ubah warna latar belakang menjadi hijau muda
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'In Process') {
      return Colors.red;
    } else if (status == 'Collected') {
      return const Color.fromARGB(255, 3, 64, 5);
    } else {
      return Colors.grey;
    }
  }
}
