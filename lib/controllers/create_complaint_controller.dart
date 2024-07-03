import 'dart:io';

import 'package:grhijau/sevices/complaint_service.dart';

class CreateComplaintController {
  final ReadComplaintsService _service = ReadComplaintsService();

  Future<void> uploadComplaint(int userId, String complaint, File image) async {
    await _service.uploadComplaint(userId, complaint, image);
  }
}
