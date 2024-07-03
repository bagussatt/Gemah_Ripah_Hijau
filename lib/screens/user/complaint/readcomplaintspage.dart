// screens/user/complaint/read_complaints_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grhijau/controllers/read_complaints_controller.dart';
import 'package:grhijau/models/complaint.dart';
import 'package:grhijau/screens/user/complaint/complaint_detail.dart';

class ReadComplaintsPage extends StatefulWidget {
  final int userId;

  ReadComplaintsPage({required this.userId});

  @override
  _ReadComplaintsPageState createState() => _ReadComplaintsPageState();
}

class _ReadComplaintsPageState extends State<ReadComplaintsPage> {
  late ReadComplaintsController _controller;
  List<Complaint> complaints = [];

  @override
  void initState() {
    super.initState();
    _controller = ReadComplaintsController(userId: widget.userId);
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    try {
      final List<Complaint> fetchedComplaints =
          await _controller.fetchComplaints();
      setState(() {
        complaints = fetchedComplaints;
      });
    } catch (e) {
      debugPrint('Gagal mengambil keluhan: $e');
    }
  }

  Future<void> _deleteComplaint(int id) async {
    try {
      await _controller.deleteComplaint(id);
      _fetchComplaints();
    } catch (e) {
      debugPrint('Gagal menghapus keluhan: $e');
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
        title: Text('Daftar Keluhan'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchComplaints,
        child: ListView.builder(
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            final complaint = complaints[index];
            return ListTile(
              leading: Image.network(complaint.photoUrl),
              title: Text('ID Keluhan: ${complaint.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_formatDateTime(complaint.waktu)),
                  Text(complaint.complaint),
                  Divider(height: 15),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ComplaintDetailPage(complaint: complaint.toJson()),
                  ),
                );
              },
            );
          },
        ),
      ),
       backgroundColor:
          Colors.lightGreen,
    );
  }
}
