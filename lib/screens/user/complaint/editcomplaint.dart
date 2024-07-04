import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grhijau/controllers/edit_complaint_controller.dart';

class EditComplaintPage extends StatefulWidget {
  final Map<String, dynamic> complaint;

  EditComplaintPage({required this.complaint});

  @override
  _EditComplaintPageState createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends State<EditComplaintPage> {
  late TextEditingController _complaintController;
  File? _image;
  final EditComplaintController _controller = EditComplaintController();

  @override
  void initState() {
    super.initState();
    _complaintController =
        TextEditingController(text: widget.complaint['complaint']);
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _updateComplaint() async {
    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gambar tidak boleh kosong.')));
      return;
    }

    bool shouldUpdate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Edit'),
          content: Text('Apakah Anda yakin ingin mengedit aduan ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Tidak'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Ya'),
            ),
          ],
        );
      },
    );

    if (!shouldUpdate) {
      return;
    }

    try {
      await _controller.updateComplaint(
          widget.complaint, _complaintController.text, _image);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint updated successfully!')));
      Navigator.pop(context, {
        'result': true,
        'complaint': _complaintController.text,
        'photo_url': widget.complaint['photo_url']
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update complaint.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Complaint'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _complaintController,
                decoration: InputDecoration(labelText: 'Complaint'),
                maxLines: 4,
              ),
              SizedBox(height: 16.0),
              _image == null ? Text('No image selected.') : Image.file(_image!),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateComplaint,
                child: Text('Update Complaint'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightGreen,
    );
  }
}
