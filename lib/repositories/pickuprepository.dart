import 'dart:convert';
import 'package:grhijau/models/pickup.dart';
import 'package:http/http.dart' as http;

class PickupRepositoryImpl implements PickupRepository {
  final String baseUrl = 'http://10.0.2.2:3000';

  @override
  Future<List<Pickup>> fetchPickups() async {
    final response = await http.get(Uri.parse('$baseUrl/pickups/read'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<Pickup> pickups = list.map((model) => Pickup.fromJson(model)).toList();
      return pickups;
    } else {
      throw Exception('Failed to fetch pickups');
    }
  }

  @override
  Future<void> deletePickup(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pickups/delete/$id'));

    if (response.statusCode == 200) {
      print('Pickup deleted successfully!');
    } else {
      throw Exception('Failed to delete pickup.');
    }
  }
}


abstract class PickupRepository {
  Future<List<Pickup>> fetchPickups();
  Future<void> deletePickup(int id);
}