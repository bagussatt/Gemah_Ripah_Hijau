import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for formatting date and time
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'; // Import for DateTimePicker

class CreatePickupPage extends StatefulWidget {
  final int userId;

  CreatePickupPage({required this.userId});

  @override
  _CreatePickupPageState createState() => _CreatePickupPageState();
}

class _CreatePickupPageState extends State<CreatePickupPage> {
  TextEditingController waktuController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController catatanController = TextEditingController();

  String _selectedDateTime = '';

  Future<void> _submitPickup() async {
    if (_selectedDateTime.isEmpty || lokasiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/pickups/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': widget.userId,
        'waktu': _selectedDateTime,
        'lokasi': lokasiController.text,
        'catatan': catatanController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah sukses
    } else {
      print('Failed to create pickup.');
    }
  }

  void _pickDateTime() {
    DatePicker.showDateTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        _selectedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
        waktuController.text = _selectedDateTime;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
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
            TextField(
              controller: waktuController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Waktu',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDateTime,
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(labelText: 'Lokasi'),
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
