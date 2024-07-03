import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminReadPickupRepository {
  Future<List<dynamic>> fetchPickups() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/pickups/read'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch pickups');
    }
  }
}
