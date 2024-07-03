import 'package:flutter/material.dart';
import 'package:grhijau/sevices/pickup_service.dart';
import 'package:intl/intl.dart';
import 'package:grhijau/models/pickup.dart';
import 'package:grhijau/screens/user/feedback/feedback.dart';

class DetailPickupsController {
  final BuildContext context;
  final Pickup pickup;
  final int userId;
  final PickupService _service = PickupService();

  DetailPickupsController({
    required this.context,
    required this.pickup,
    required this.userId,
  });

  String get formattedDateTime {
    DateTime dateTime = DateTime.parse(pickup.waktu);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  Color getStatusColor(String status) {
    if (status == 'In Process') {
      return Colors.red;
    } else if (status == 'Collected') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Future<void> deletePickup(int id) async {
    try {
      await _service.deletePickup(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup deleted successfully')),
      );
      Navigator.pop(context, true); // Return to the previous page after deletion
    } catch (e) {
      print('Exception during pickup deletion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete pickup')),
      );
    }
  }

  void navigateToFeedbackPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackPage(
          userId: userId,
          pickupId: pickup.id,
        ),
      ),
    );
  }
}
