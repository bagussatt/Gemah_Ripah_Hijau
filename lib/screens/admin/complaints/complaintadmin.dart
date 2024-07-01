import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/complaint/complaint_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Import package for date formatting

class ReadComplaintsAdmin extends StatefulWidget {
  @override
  _ReadComplaintsAdminState createState() => _ReadComplaintsAdminState();
}

class _ReadComplaintsAdminState extends State<ReadComplaintsAdmin> {
  List<Map<String, dynamic>> complaints = [];

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/complaints/images'));

    if (response.statusCode == 200) {
      setState(() {
        complaints =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load complaints.');
    }
  }

  Future<void> _deleteComplaint(int id) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:3000/complaints/images/$id'));

    if (response.statusCode == 200) {
      print('Complaint deleted successfully!');
      _fetchComplaints();
    } else {
      print('Failed to delete complaint.');
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Complaints'),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return ListTile(
            leading: Image.network(complaint['photo_url']),
            title: Text('Complaint ID: ${complaint['id']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_formatDateTime(complaint['waktu'])),
                Text(complaint['complaint']),
                Divider(height: 15),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintDetailPage(
                    complaint: complaint,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
