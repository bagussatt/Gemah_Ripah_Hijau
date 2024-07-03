import 'package:flutter/material.dart';
import 'package:grhijau/controllers/complaint_detail_controller.dart';
import 'package:grhijau/screens/user/complaint/editcomplaint.dart';
import 'package:intl/intl.dart';

class ComplaintDetailPage extends StatefulWidget {
  final Map<String, dynamic> complaint;

  ComplaintDetailPage({required this.complaint});

  @override
  _ComplaintDetailPageState createState() => _ComplaintDetailPageState();
}

class _ComplaintDetailPageState extends State<ComplaintDetailPage> {
  late bool _isComplaintUpdated;
  final ComplaintDetailController _controller = ComplaintDetailController();

  @override
  void initState() {
    super.initState();
    _isComplaintUpdated = false;
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
            onPressed: () async {
              await _controller.deleteComplaint(widget.complaint['id']);
              Navigator.pop(context, true);
            },
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
            if (_isComplaintUpdated)
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
      backgroundColor: Colors.lightGreen,
    );
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }
}
