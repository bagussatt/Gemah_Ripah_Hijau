import 'package:flutter/material.dart';
import 'package:grhijau/models/admin/admin_read_pickup.dart';
import 'package:grhijau/repositories/admin/adminread_pickup_repository.dart';

class AdminReadPickupService {
  final AdminReadPickupRepository pickupRepository;

  AdminReadPickupService({required this.pickupRepository});

  Future<List<AdminReadPickup>> fetchPickups(BuildContext context) async {
    try {
      List<dynamic> pickups = await pickupRepository.fetchPickups();
      return pickups.map((json) => AdminReadPickup.fromJson(json)).toList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch pickups: $e')),
      );
      return [];
    }
  }
}
