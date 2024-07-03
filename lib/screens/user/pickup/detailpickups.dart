import 'package:flutter/material.dart';
import 'package:grhijau/controllers/pickupcontroller.dart';
import 'package:grhijau/models/pickup.dart';

class DetailPickupsPage extends StatelessWidget {
  final Map<String, dynamic> pickup;
  final int userId;

  DetailPickupsPage({required this.pickup, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Detail'),
        backgroundColor: Color.fromARGB(255, 29, 154, 77),
      ),
      body: Builder(
        builder: (BuildContext context) {
          final controller = DetailPickupsController(
            context: context,
            pickup: Pickup.fromJson(pickup),
            userId: userId,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Status: ${pickup['status']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Waktu: ${controller.formattedDateTime}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Lokasi: ${pickup['lokasi']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Catatan: ${pickup['catatan'] ?? 'Tidak ada catatan'}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _confirmCancelPickup(context),
                      child: Text('Batalkan Penjemput'),
                    ),
                    ElevatedButton(
                      onPressed: pickup['status'] == 'Collected'
                          ? () => controller.navigateToFeedbackPage()
                          : null,
                      child: Text('Submit Feedback'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.lightGreen,
    );
  }

  void _confirmCancelPickup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Batalkan Penjemputan'),
          content: Text('Apakah Anda yakin ingin membatalkan penjemputan ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                final controller = DetailPickupsController(
                  context: context,
                  pickup: Pickup.fromJson(pickup),
                  userId: userId,
                );
                controller.deletePickup(pickup['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
