import 'package:flutter/material.dart';
import 'package:grhijau/screens/user/complaint/editcomplaint.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ComplaintDetailPage extends StatefulWidget {
  final Map<String, dynamic> complaint;

  ComplaintDetailPage({required this.complaint});

  @override
  _ComplaintDetailPageState createState() => _ComplaintDetailPageState();
}

class _ComplaintDetailPageState extends State<ComplaintDetailPage> {
  bool _isComplaintUpdated = false;

  Future<void> _deleteComplaint(BuildContext context, int id) async {
    final response = await http
        .delete(Uri.parse('http://10.0.2.2:3000/complaints/images/$id'));

    if (response.statusCode == 200) {
      print('Complaint deleted successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint deleted successfully')),
      );
      Navigator.pop(
          context, true); // Kembali ke halaman sebelumnya setelah penghapusan
    } else {
      print('Failed to delete complaint.');
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  void _updateComplaintDetail(
      bool isUpdated, Map<String, dynamic> updatedComplaint) {
    if (isUpdated) {
      setState(() {
        widget.complaint['complaint'] = updatedComplaint['complaint'];
        widget.complaint['photo_url'] = updatedComplaint['photo_url'];
        _isComplaintUpdated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              Map<String, dynamic>? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditComplaintPage(complaint: widget.complaint),
                ),
              );
              if (result != null && result['result']) {
                _updateComplaintDetail(true, {
                  'complaint': result['complaint'],
                  'photo_url': result['photo_url'],
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteComplaint(context, widget.complaint['id']),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Complaint ID: ${widget.complaint['id']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              _formatDateTime(widget.complaint['waktu']),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.complaint['complaint'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Image.network(widget.complaint['photo_url']),
            if (_isComplaintUpdated) // Tampilkan pesan setelah berhasil update
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Complaint updated successfully!',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
