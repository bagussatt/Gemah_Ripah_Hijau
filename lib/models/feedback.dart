import 'dart:convert';

class FeedbackModel {
  final int userId;
  final int pickupId;
  final String feedback;
  final int rating;

  FeedbackModel({
    required this.userId,
    required this.pickupId,
    required this.feedback,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'pickup_id': pickupId,
      'feedback': feedback,
      'rating': rating,
    };
  }
}
