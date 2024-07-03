import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackRepository {
  static const String baseUrl = 'http://10.0.2.2:3000';
  static const String createFeedbackEndpoint = '/feedback/create';

  Future<bool> submitFeedback({
    required int userId,
    required int pickupId,
    required String feedback,
    required int rating,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + createFeedbackEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'pickup_id': pickupId,
          'feedback': feedback,
          'rating': rating,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to submit feedback: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception while submitting feedback: $e');
      return false;
    }
  }
}
