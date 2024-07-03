import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grhijau/controllers/create_complaint_controller.dart';

class CreateComplaintPage extends StatefulWidget {
  final int userId;

  CreateComplaintPage({required this.userId});

  @override
  _CreateComplaintPageState createState() => _CreateComplaintPageState();
}

class _CreateComplaintPageState extends State<CreateComplaintPage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _complaintController = TextEditingController();
  bool _isUploading = false;
  final CreateComplaintController _controller = CreateComplaintController();

  Future<void> _takePicture() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image taken.');
      }
    });
  }

  Future<void> _uploadComplaint() async {
    if (_image == null || _complaintController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image and enter your complaint'),
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      await _controller.uploadComplaint(
        widget.userId,
        _complaintController.text,
        _image!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint uploaded successfully!')),
      );

      Navigator.pop(
          context); // Kembali ke halaman sebelumnya setelah upload berhasil
    } catch (e) {
      print('Error uploading complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading complaint. Please try again later.'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Complaint'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _takePicture,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _complaintController,
              decoration: InputDecoration(
                hintText: 'Enter your complaint',
                labelText: 'Complaint',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadComplaint,
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Upload Complaint'),
            ),
          ],
        ),
      ),
       backgroundColor:
          Colors.lightGreen,
    );
  }
}
