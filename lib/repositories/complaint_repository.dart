// repositories/read_complaints_repository.dart
import 'package:grhijau/models/complaint.dart';
import 'package:grhijau/sevices/complaint_service.dart';

class ReadComplaintsRepository {

  Future<List<Complaint>> fetchComplaints(int userId) async {
    try {
      return await ReadComplaintsService.fetchComplaints(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteComplaint(int id) async {
    try {
      await ReadComplaintsService.deleteComplaint(id);
    } catch (e) {
      rethrow;
    }
  }
}
