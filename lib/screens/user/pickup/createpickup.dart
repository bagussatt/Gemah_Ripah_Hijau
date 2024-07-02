import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/pickup/lokasi.dart';
import 'package:http/http.dart' as http;

class CreatePickupPage extends StatefulWidget {
  final int userId;

  CreatePickupPage({required this.userId});

  @override
  _CreatePickupPageState createState() => _CreatePickupPageState();
}

class _CreatePickupPageState extends State<CreatePickupPage> {
  TextEditingController catatanController = TextEditingController();

  String? _selectedTime;
  String? _lokasi;

  final List<String> times = [
    '08:00:00',
    '09:00:00',
    '10:00:00',
    '11:00:00',
    '12:00:00',
    '13:00:00',
    '14:00:00',
    '15:00:00',
    '16:00:00',
    '17:00:00',
  ];

  Future<void> _submitPickup() async {
    if (_selectedTime == null || _lokasi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    String currentDate = DateTime.now()
        .toString()
        .split(' ')[0]; // Get current date in YYYY-MM-DD format
    String dateTime = '$currentDate $_selectedTime';

    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/pickups/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': widget.userId,
        'waktu': dateTime,
        'lokasi': _lokasi,
        'catatan': catatanController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah sukses
    } else {
      print('Failed to create pickup.');
    }
  }

  void _selectLocation() async {
    String? location = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          onLocationSelected: (location) {
            setState(() {
              _lokasi = location;
            });
          },
        ),
      ),
    );
    if (location != null) {
      setState(() {
        _lokasi = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Pickup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('Select Time'),
              value: _selectedTime,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTime = newValue;
                });
              },
              items: times.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: _selectLocation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _lokasi ?? 'Pilih Lokasi',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.location_on),
                ],
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: catatanController,
              decoration: InputDecoration(labelText: 'Catatan'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitPickup,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
