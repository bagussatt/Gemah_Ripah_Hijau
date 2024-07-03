import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grhijau/models/createpickup.dart';

class CreatePickupRepository {
  Future<bool> createPickup(CreatePickup pickup) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/pickups/create'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pickup.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create pickup: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during pickup creation: $e');
      return false;
    }
  }
}
