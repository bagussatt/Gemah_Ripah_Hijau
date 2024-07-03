import 'package:flutter/material.dart';
import 'package:grhijau/models/feedback.dart';
import 'package:grhijau/repositories/feedback_repository.dart';

class FeedbackService {
  final FeedbackRepository _repository = FeedbackRepository();

  Future<bool> submitFeedback({
    required int userId,
    required int pickupId,
    required String feedback,
    required int rating,
    required BuildContext context,
  }) async {
    try {
      bool success = await _repository.submitFeedback(
        userId: userId,
        pickupId: pickupId,
        feedback: feedback,
        rating: rating,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Feedback submitted successfully')),
        );
        Navigator.pop(context);
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback')),
        );
        return false;
      }
    } catch (e) {
      print('Exception while submitting feedback: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit feedback')),
      );
      return false;
    }
  }
}
