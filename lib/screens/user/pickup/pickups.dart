import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/pickup/createpickup.dart';
import 'package:grhijau/screens/user/pickup/detailpickups.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PickupPage extends StatefulWidget {
  final int userId;

  PickupPage({required this.userId});

  @override
  _PickupPageState createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  List<Map<String, dynamic>> pickups = [];

  @override
  void initState() {
    super.initState();
    _fetchPickups();
  }

  Future<void> _fetchPickups() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/pickups/read'));

    if (response.statusCode == 200) {
      setState(() {
        pickups = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load pickups.');
    }
  }
  Future<void> _feetchfeedback() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/pickups/read'));

    if (response.statusCode == 200) {
      setState(() {
        pickups = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load pickups.');
    }
  }

  Future<void> _deletePickup(int id) async {
    final response =
        await http.delete(Uri.parse('http://10.0.2.2:3000/pickups/delete/$id'));

    if (response.statusCode == 200) {
      print('Pickup deleted successfully!');
      _fetchPickups();
    } else {
      print('Failed to delete pickup.');
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  Color _getStatusColor(String status) {
    if (status == 'In Process') {
      return Colors.red;
    } else if (status == 'Collected') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePickupPage(userId: widget.userId),
            ),
          ).then((_) {
            _fetchPickups();
          });
        },
        child: Icon(Icons.add),
      ),
      body: pickups.isEmpty
          ? Center(
              child: Text('No pickups available'),
            )
          : ListView.builder(
              itemCount: pickups.length,
              itemBuilder: (context, index) {
                final pickup = pickups[index];
                return ListTile(
                  title: Text('Pickup ID: ${pickup['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Waktu: ${_formatDateTime(pickup['waktu'])}'),
                      Text('Lokasi: ${pickup['lokasi']}'),
                      Text('Catatan: ${pickup['catatan']}'),
                      Divider(height: 15),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(pickup['status']).withOpacity(0.1),
                      border: Border.all(
                        color: _getStatusColor(pickup['status']),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      pickup['status'],
                      style: TextStyle(
                        color: _getStatusColor(pickup['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPickupsPage(
                            userId: widget.userId, pickup: pickup),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
