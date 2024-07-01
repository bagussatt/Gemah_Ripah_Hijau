import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
            content: Text('Please select an image and enter your complaint')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    final uri = Uri.parse('http://10.0.2.2:3000/complaints/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path))
      ..fields['user_id'] = widget.userId.toString()
      ..fields['complaint'] = _complaintController.text;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Complaint uploaded successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint uploaded successfully!')),
        );
        Navigator.pop(
            context); // Kembali ke halaman sebelumnya setelah upload berhasil
      } else {
        print('Complaint upload failed.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint upload failed.')),
        );
      }
    } catch (e) {
      print('Error uploading complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error uploading complaint. Please try again later.')),
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
    );
  }
}
