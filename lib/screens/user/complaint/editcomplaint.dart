import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditComplaintPage extends StatefulWidget {
  final Map<String, dynamic> complaint;

  EditComplaintPage({required this.complaint});

  @override
  _EditComplaintPageState createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends State<EditComplaintPage> {
  late TextEditingController _complaintController;
  File? _image;

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
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'http://10.0.2.2:3000/complaints/images/${widget.complaint['id']}'));
    request.fields['complaint'] = _complaintController.text;

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint updated successfully!')));

      // Mengirim kembali hasil true dan nilai keluhan yang diperbarui ke halaman sebelumnya
      Navigator.pop(context, {
        'result': true,
        'complaint': _complaintController.text,
        'photo_url': widget.complaint['photo_url']
      });
    } else {
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
    );
  }
}
