// services/read_complaints_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:grhijau/models/complaint.dart';

class ReadComplaintsService {
  static Future<List<Complaint>> fetchComplaints(int userId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/complaints/user/$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<Complaint> complaints = jsonList.map((json) => Complaint.fromJson(json)).toList();
      return complaints;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  static Future<void> deleteComplaint(int id) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:3000/complaints/images/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete complaint');
    }
  }

  Future<void> updateComplaint(Map<String, dynamic> complaint, String updatedComplaint, File? imageFile) async {
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://10.0.2.2:3000/complaints/images/${complaint['id']}'));
    request.fields['complaint'] = updatedComplaint;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    var response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to update complaint');
    }
  }
  Future<void> uploadComplaint(int userId, String complaint, File image) async {
    var uri = Uri.parse('http://10.0.2.2:3000/complaints/upload');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', image.path))
      ..fields['user_id'] = userId.toString()
      ..fields['complaint'] = complaint;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Complaint uploaded successfully!');
    } else {
      print('Failed to upload complaint.');
      throw Exception('Failed to upload complaint');
    }
  }
}
