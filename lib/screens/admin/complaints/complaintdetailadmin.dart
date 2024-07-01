import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintsDetailAdmin extends StatelessWidget {
  final Map<String, dynamic> complaint;

  ComplaintsDetailAdmin({required this.complaint});

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Complaint ID: ${complaint['id']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text("cek"),
            Text(
              _formatDateTime(complaint['waktu']),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              complaint['complaint'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Image.network(complaint['photo_url']),
          ],
        ),
      ),
    );
  }
}
