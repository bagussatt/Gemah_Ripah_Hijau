import 'package:flutter/material.dart';

enum PickupStatus {
  inProcess,
  collected,
}

class DetailPickupModel {
  final int pickupId;
  PickupStatus? status;
  String? catatan;
  String? waktu;
  String? lokasi;

  DetailPickupModel({
    required this.pickupId,
    this.status,
    this.catatan,
    this.waktu,
    this.lokasi,
  });

  factory DetailPickupModel.fromJson(Map<String, dynamic> json) {
    return DetailPickupModel(
      pickupId: json['id'],
      status: _parseStatus(json['status']),
      catatan: json['catatan'],
      waktu: json['waktu'],
      lokasi: json['lokasi'],
    );
  }

  static PickupStatus? _parseStatus(String? statusString) {
    switch (statusString?.toLowerCase()) {
      case 'in process':
        return PickupStatus.inProcess;
      case 'collected':
        return PickupStatus.collected;
      default:
        return null;
    }
  }
}
