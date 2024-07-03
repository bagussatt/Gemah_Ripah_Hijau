import 'package:flutter/material.dart';
import 'package:grhijau/models/admin/detailpckupmodel.dart';
import 'package:grhijau/sevices/admin/DetailPickupService.dart';

class DetailPickupController {
  final DetailPickupService service;

  DetailPickupController({required this.service});

  Future<DetailPickupModel> fetchPickupDetail(int pickupId, BuildContext context) async {
    return await service.fetchPickupDetail(pickupId, context);
  }

  Future<bool> updatePickupStatus(int pickupId, String newStatus, String catatan, BuildContext context) async {
    return await service.updatePickupStatus(pickupId, newStatus, catatan, context);
  }
}
