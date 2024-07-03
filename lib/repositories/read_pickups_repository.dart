import 'dart:convert';
import 'package:grhijau/models/readpickup.dart';
import 'package:http/http.dart' as http;

class ReadPickupsRepository {
  Future<List<ReadPickup>> fetchPickups() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/pickups/read'));

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      List<ReadPickup> pickups = jsonList.map((model) => ReadPickup.fromJson(model)).toList();
      return pickups;
    } else {
      throw Exception('Failed to load pickups');
    }
  }
}
