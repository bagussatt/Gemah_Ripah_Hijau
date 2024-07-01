import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<void> createComplaint(
      int userId, String complaint, String photoPath) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/complaints'));
    request.fields['user_id'] = userId.toString();
    request.fields['complaint'] = complaint;
    if (photoPath != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', photoPath));
    }

    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to create complaint');
    }
  }

  Future<List<Complaint>> getComplaints() async {
    final response = await http.get(Uri.parse('$baseUrl/complaints'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Complaint.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load complaints');
    }
  }
}

class Complaint {
  final int id;
  final int userId;
  final String complaint;
  final String? photoBase64;

  Complaint({required this.id, required this.userId, required this.complaint, this.photoBase64});

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      userId: json['user_id'],
      complaint: json['complaint'],
      photoBase64: json['photo_url'],
    );
  }

  Image? get photo {
    if (photoBase64 != null) {
      return Image.memory(base64Decode(photoBase64!));
    }
    return null;
  }
}
