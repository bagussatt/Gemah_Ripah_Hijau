// complaint_model.dart

import 'package:intl/intl.dart';

class Complaint {
  final int id;
  final String waktu;
  final String complaint;
  final String photoUrl;

  Complaint({
    required this.id,
    required this.waktu,
    required this.complaint,
    required this.photoUrl,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json['id'],
        waktu: json['waktu'],
        complaint: json['complaint'],
        photoUrl: json['photo_url'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'waktu': waktu,
      'complaint': complaint,
      'photo_url': photoUrl,
    };
  }

  String formattedDateTime() {
    DateTime dateTime = DateTime.parse(waktu);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dateTime);
  }
}
