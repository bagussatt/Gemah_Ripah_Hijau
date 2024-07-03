import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grhijau/controllers/feedback_controller.dart';

class FeedbackPage extends StatefulWidget {
  final int userId;
  final int pickupId;

  FeedbackPage({required this.userId, required this.pickupId});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FeedbackController _controller = FeedbackController();
  TextEditingController feedbackController = TextEditingController();
  double rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(labelText: 'Feedback'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.submitFeedback(
                  userId: widget.userId,
                  pickupId: widget.pickupId,
                  feedback: feedbackController.text,
                  rating: rating.toInt(),
                  context: context,
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
       backgroundColor:
          Colors.lightGreen,
    );
  }
}
