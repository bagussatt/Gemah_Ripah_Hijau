import 'package:grhijau/models/pickup.dart';
import 'package:grhijau/repositories/pickuprepository.dart';

class PickupService {
  final PickupRepository _repository = PickupRepository();

  Future<List<Pickup>> fetchPickups() async {
    return await _repository.fetchPickups();
  }

  Future<void> deletePickup(int id) async {
    await _repository.deletePickup(id);
  }
}
