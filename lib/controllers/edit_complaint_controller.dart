
import 'dart:io';

import 'package:grhijau/sevices/complaint_service.dart';

class EditComplaintController {
  final ReadComplaintsService _service = ReadComplaintsService();

  Future<void> updateComplaint(Map<String, dynamic> complaint, String updatedComplaint, File? imageFile) async {
    await _service.updateComplaint(complaint, updatedComplaint, imageFile);
  }
}
