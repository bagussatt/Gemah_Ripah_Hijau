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
                  'Catatan: ${pickup['catatan']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => controller.deletePickup(pickup['id']),
                  child: Text('Batalkan Penjemput'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => controller.navigateToFeedbackPage(),
                  child: Text('Submit Feedback'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
