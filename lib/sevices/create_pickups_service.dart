
import 'package:flutter/material.dart';
import 'package:grhijau/models/createpickup.dart';
import 'package:grhijau/repositories/createpickuprepository.dart';

class CreatePickupService {
  final CreatePickupRepository pickupRepository;

  CreatePickupService({required this.pickupRepository});

  Future<bool> submitPickup(BuildContext context, int userId, String waktu, String lokasi) async {
    CreatePickup pickup = CreatePickup(userId: userId, waktu: waktu, lokasi: lokasi);
    bool result = await pickupRepository.createPickup(pickup);
    if (result) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup created successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create pickup')),
      );
    }
    return result;
  }
   
}
