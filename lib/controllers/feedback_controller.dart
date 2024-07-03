import 'package:flutter/material.dart';
import 'package:grhijau/sevices/feedback_service.dart';

class FeedbackController {
  final FeedbackService _service = FeedbackService();

  Future<void> submitFeedback({
    required int userId,
    required int pickupId,
    required String feedback,
    required int rating,
    required BuildContext context,
  }) async {
    await _service.submitFeedback(
      userId: userId,
      pickupId: pickupId,
      feedback: feedback,
      rating: rating,
      context: context,
    );
  }
}
