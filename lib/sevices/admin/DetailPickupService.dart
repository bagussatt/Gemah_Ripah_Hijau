import 'package:flutter/material.dart';
import 'package:grhijau/models/admin/detailpckupmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPickupService {
  final String baseUrl;

  DetailPickupService({required this.baseUrl});

  Future<DetailPickupModel> fetchPickupDetail(int pickupId, BuildContext context) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pickups/$pickupId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final pickup = json.decode(response.body);
      return DetailPickupModel(
        pickupId: pickupId,
        status: pickup['status'],
        catatan: pickup['catatan'],
        waktu: pickup['waktu'],
        lokasi: pickup['lokasi'],
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch pickup details')),
      );
      return DetailPickupModel(pickupId: pickupId);
    }
  }

  Future<bool> updatePickupStatus(int pickupId, String newStatus, String catatan, BuildContext context) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pickups/update/$pickupId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': newStatus,
        'catatan': catatan,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup status updated successfully')),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update pickup status')),
      );
      return false;
    }
  }
}
