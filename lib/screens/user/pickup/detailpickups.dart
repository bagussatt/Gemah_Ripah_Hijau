import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/feedback/feedback.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class DetailPickupsPage extends StatefulWidget {
  final Map<String, dynamic> pickup;
  final int userId;

  DetailPickupsPage({required this.pickup, required this.userId});

  @override
  _DetailPickupsPageState createState() => _DetailPickupsPageState();
}

class _DetailPickupsPageState extends State<DetailPickupsPage> {
  bool _isPickupDeleted = false;

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  Future<void> _deletePickup(BuildContext context, int id) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:3000/pickups/delete/$id'),
    );

    if (response.statusCode == 200) {
      print('Pickup deleted successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup deleted successfully')),
      );
      setState(() {
        _isPickupDeleted = true;
      });
      Navigator.pop(context, true); // Return to the previous page after deletion
    } else {
      print('Failed to delete pickup.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete pickup')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isPickupDeleted) {
      // Return an empty container if the pickup is deleted
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Status: ${widget.pickup['status']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Waktu: ${_formatDateTime(widget.pickup['waktu'])}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Lokasi: ${widget.pickup['lokasi']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'Catatan: ${widget.pickup['catatan']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _deletePickup(context, widget.pickup['id']),
              child: Text('Batalkan Penjemput'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(
                      userId: widget.userId,
                      pickupId: widget.pickup['id'],
                    ),
                  ),
                );
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
