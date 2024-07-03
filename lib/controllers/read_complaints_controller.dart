// controllers/read_complaints_controller.dart
import 'package:flutter/material.dart';
import 'package:grhijau/models/complaint.dart';
import 'package:grhijau/repositories/complaint_repository.dart';

class ReadComplaintsController {
  final ReadComplaintsRepository _repository = ReadComplaintsRepository();
  final int userId;

  ReadComplaintsController({required this.userId});

  Future<List<Complaint>> fetchComplaints() async {
    try {
      return await _repository.fetchComplaints(userId);
    } catch (e) {
      debugPrint('Failed to fetch complaints: $e');
      rethrow;
    }
  }

  Future<void> deleteComplaint(int id) async {
    try {
      await _repository.deleteComplaint(id);
    } catch (e) {
      debugPrint('Failed to delete complaint: $e');
      rethrow;
    }
  }
}
