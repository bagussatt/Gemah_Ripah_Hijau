import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<Map<String, dynamic>> feedbacks = [];
  int selectedRatingFilter = 0; // Default: no filter

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  Future<void> _fetchFeedbacks() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/feedback/read'));

    if (response.statusCode == 200) {
      setState(() {
        feedbacks = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      print('Failed to load feedbacks.');
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }

  void _filterFeedbacks(int rating) {
    setState(() {
      selectedRatingFilter = rating;
    });
  }

  List<Map<String, dynamic>> getFilteredFeedbacks() {
    if (selectedRatingFilter == 0) {
      return feedbacks; // No filter applied
    } else {
      return feedbacks
          .where((feedback) => feedback['rating'] == selectedRatingFilter)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // List of feedbacks
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: getFilteredFeedbacks().length,
              itemBuilder: (context, index) {
                final feedback = getFilteredFeedbacks()[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('Feedback ID: ${feedback['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Feedback: ${feedback['feedback']}'),
                        Text('Rating: ${feedback['rating']}'),
                        Text(
                            'Submitted At: ${_formatDateTime(feedback['created_at'])}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Feedbacks'),
          content: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Filter by Rating',
              border: OutlineInputBorder(),
            ),
            value: selectedRatingFilter,
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text('Clear Filter'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('1 Star'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('2 Stars'),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text('3 Stars'),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text('4 Stars'),
              ),
              DropdownMenuItem(
                value: 5,
                child: Text('5 Stars'),
              ),
            ],
            onChanged: (value) {
              Navigator.of(context).pop();
              _filterFeedbacks(value as int);
            },
          ),
        );
      },
    );
  }
}
