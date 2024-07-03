import 'dart:convert';
import 'package:grhijau/models/pickup.dart';
import 'package:http/http.dart' as http;

class PickupRepository {
  final String baseUrl = 'http://10.0.2.2:3000/pickups'; // Sesuaikan dengan URL API Anda

  Future<List<Pickup>> fetchPickups() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Pickup.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load pickups');
      }
    } catch (e) {
      throw Exception('Failed to load pickups: $e');
    }
  }

  Future<void> deletePickup(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
      if (response.statusCode == 200) {
        print('Pickup deleted successfully!');
      } else {
        throw Exception('Failed to delete pickup');
      }
    } catch (e) {
      throw Exception('Failed to delete pickup: $e');
    }
  }
}
