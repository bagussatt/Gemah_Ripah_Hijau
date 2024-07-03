import 'package:grhijau/models/readpickup.dart';
import 'package:grhijau/repositories/read_pickups_repository.dart';

class ReadPickupsService {
  final ReadPickupsRepository _repository = ReadPickupsRepository();

  Future<List<ReadPickup>> fetchPickups() async {
    return await _repository.fetchPickups();
  }
}
