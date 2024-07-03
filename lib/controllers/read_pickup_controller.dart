import 'package:grhijau/models/readpickup.dart';
import 'package:grhijau/sevices/read_pickups_service.dart';

class ReadPickupsController {
  final ReadPickupsService _service = ReadPickupsService();

  Future<List<ReadPickup>> fetchPickups() async {
    try {
      return await _service.fetchPickups();
    } catch (e) {
      print('Error fetching pickups: $e');
      throw Exception('Failed to fetch pickups');
    }
  }
}
