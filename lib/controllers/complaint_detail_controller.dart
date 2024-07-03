import 'package:grhijau/sevices/complaint_service.dart';

class ComplaintDetailController {

  Future<void> deleteComplaint(int id) async {
    await ReadComplaintsService.deleteComplaint(id);
  }
}
